import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/home/home_screen.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/margin.dart';


class RegisterScreen extends StatefulWidget {
  static const name = 'register-screen';
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;

  Future<void> _register() async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar datos adicionales del usuario en Firestore
      await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user?.uid).set({
        'username': username,
        'email': email,
      });

     
      context.go('/${HomeScreen.name}');
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'El correo electrónico ya está en uso.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es demasiado débil.';
      } else {
        errorMessage = 'Ocurrió un error. Por favor, inténtelo de nuevo.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Margin(
        height: height,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
              const SizedBox(height: 45),
              const CustomTitle('Crear cuenta'),
              const SizedBox(height: 30),
              const CustomSubTitle(
                'Ingresa tu correo electrónico y contraseña.',
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Nombre usuario',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre de usuario';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Correo',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor ingrese un correo válido';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                isPassword: true,
                labelText: 'Contraseña',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                isPassword: true,
                labelText: 'Confirmar contraseña',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirme su contraseña';
                  }
                  if (value != password) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
              ),
              const Spacer(),
              CustomButton(
                text: isLoading ? 'Cargando...' : 'Registrar',
                isValid: true,
                onPressed: () {
                  if (_formKey.currentState!.validate() && !isLoading) {
                    _register();
                  }
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
