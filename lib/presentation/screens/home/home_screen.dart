import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/publication/publication_screen.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(PublicationScreen.name);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
