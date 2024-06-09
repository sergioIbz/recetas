import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/auth/login/login_screen.dart';
import 'package:recetas/presentation/screens/auth/register/register_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/${LoginScreen.name}',
  routes: [
    GoRoute(
      path: '/${LoginScreen.name}',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/${RegisterScreen.name}',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
