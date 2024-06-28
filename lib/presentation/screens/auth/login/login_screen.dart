import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:recetas/presentation/screens/home/home_screen.dart';
import '../../../../config/theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/margin.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navegar a la pantalla principal después de un inicio de sesión exitoso
      context.go('/${HomeScreen.name}');
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No se encontró un usuario con ese correo.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'La contraseña es incorrecta.';
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
              const SizedBox(height: 45),
              const CustomTitle('Bienvenido'),
              const SizedBox(height: 25),
              const CustomSubTitle(
                'Por favor ingrese su correo electrónico y contraseña para iniciar sesión',
              ),
              const SizedBox(height: 50),
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
                onChanged: (text) {
                  setState(() {
                    email = text;
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
                onChanged: (text) {
                  setState(() {
                    password = text;
                  });
                },
              ),
              const Spacer(flex: 1),
              CustomTextButton(
                text: '¿Olvidó su contraseña?',
                color: AppTheme.firstColor,
                onPressed: () {
                  context.pushNamed(ForgotPasswordScreen.name);
                },
              ),
              const Spacer(flex: 2),
              CustomButton(
                text: isLoading ? 'Cargando...' : 'Ingresar',
                isValid: true,
                onPressed: () {
                  if (_formKey.currentState!.validate() && !isLoading) {
                    _signIn();
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                text: '¿No tienes cuenta?',
                onPressed: () =>
                    context.pushReplacementNamed(RegisterScreen.name),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
