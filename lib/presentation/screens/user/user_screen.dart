import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/auth/login/login_screen.dart';


class UserScreen extends StatefulWidget {
  static const name = "user-screen";
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  User? user;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).get();
        if (userDoc.exists) {
          setState(() {
            _usernameController.text = userDoc['username'] ?? '';
            _emailController.text = userDoc['email'] ?? '';
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar los datos del usuario: $e')),
        );
      }
    }
  }

  Future<void> _updateUserData() async {
    if (user != null) {
      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).update({
          'username': _usernameController.text,
          'email': _emailController.text,
        });

        if (user!.email != _emailController.text) {
          await user!.updateEmail(_emailController.text);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos actualizados correctamente')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar los datos: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    context.go('/${LoginScreen.name}');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : _updateUserData,
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signOut,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cerrar Sesión'),
                  ),
                ],
              ),
            ),
    );
  }
}
