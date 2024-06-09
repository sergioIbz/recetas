import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final focus = FocusScope.of(context);
        final focusChild = focus.focusedChild;
        if (focusChild != null && !focusChild.hasPrimaryFocus) {
          focusChild.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Material App',
        routerConfig: appRouter,
        theme: AppTheme().getTheme(context),
      ),
    );
  }
}
