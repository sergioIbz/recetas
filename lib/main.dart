import 'package:flutter/material.dart';
import 'package:recetas/config/router/app_router.dart';
import 'package:recetas/config/theme/app_theme.dart';

void main() => runApp(const MyApp());

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
