import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/widgets/custom_button.dart';
import 'package:recetas/presentation/screens/widgets/custom_text.dart';
import 'package:recetas/presentation/screens/widgets/custom_title.dart';
import 'package:recetas/presentation/screens/widgets/margin.dart';

import '../home/home_screen.dart';

class PublicationScreen extends StatefulWidget {
  static const name = 'publication-screen';
  const PublicationScreen({super.key});

  @override
  _PublicationScreenState createState() => _PublicationScreenState();
}

class _PublicationScreenState extends State<PublicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String recipeName = '';
  String description = '';
  String videoUrl = '';
  bool isLoading = false;

  Future<void> _publishRecipe() async {
    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No estás autenticado.')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('recetas').add({
        'nombre': recipeName,
        'descripcion': description,
        'videoUrl': videoUrl,
        'uid': user.uid, // Agregar el UID del usuario
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Navegar a la pantalla principal después de una publicación exitosa
      context.go('/${HomeScreen.name}');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Ocurrió un error. Por favor, inténtelo de nuevo.')),
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
              const CustomTitle('Publicar Receta'),
              const SizedBox(height: 30),
              const CustomSubTitle(
                'Ingrese los detalles de su receta.',
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Nombre de la receta',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la receta';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    recipeName = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Descripción',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'URL del video de YouTube',
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
                  setState(() {
                    videoUrl = value;
                  });
                },
              ),
              const Spacer(),
              CustomButton(
                text: isLoading ? 'Cargando...' : 'Publicar',
                isValid: true,
                onPressed: () {
                  if (_formKey.currentState!.validate() && !isLoading) {
                    _publishRecipe();
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
