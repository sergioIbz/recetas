import 'package:flutter/material.dart';

import 'package:recetas/config/router/app_router.dart';
import 'package:recetas/config/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Recetas app',
      routerConfig: appRouter,
      theme: AppTheme().getTheme(context),
    );
  }
}
