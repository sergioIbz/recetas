import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  DeleteScreenState createState() => DeleteScreenState();
}

class DeleteScreenState extends State<DeleteScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _showDeleteDialog(String docId, String title) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Receta'),
          content:
              Text('¿Estás seguro de que deseas eliminar la receta "$title"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('recetas')
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: Text('No estás autenticado.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Publicaciones'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recetas')
            .where('uid', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tienes publicaciones.'));
          }

          final recetas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];

              return ListTile(
                title: Text(receta['nombre']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(receta.id, receta['nombre']);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
