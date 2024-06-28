import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  EditScreenState createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _showEditDialog(String docId, String initialTitle,
      String initialDescription, String initialVideoUrl) async {
    final _formKey = GlobalKey<FormState>();
    String title = initialTitle;
    String description = initialDescription;
    String videoUrl = initialVideoUrl;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Receta'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: title,
                  decoration:
                      const InputDecoration(labelText: 'Nombre de la receta'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre de la receta';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
                TextFormField(
                  initialValue: videoUrl,
                  decoration: const InputDecoration(
                      labelText: 'URL del video de YouTube'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la URL del video de YouTube';
                    }
                    if (!RegExp(
                            r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$')
                        .hasMatch(value)) {
                      return 'Por favor ingrese una URL válida de YouTube';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    videoUrl = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await FirebaseFirestore.instance
                      .collection('recetas')
                      .doc(docId)
                      .update({
                    'nombre': title,
                    'descripcion': description,
                    'videoUrl': videoUrl,
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
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
                onTap: () {
                  _showEditDialog(
                    receta.id,
                    receta['nombre'],
                    receta['descripcion'],
                    receta['videoUrl'],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
