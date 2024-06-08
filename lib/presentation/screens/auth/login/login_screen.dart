import 'package:flutter/material.dart';
import 'package:recetas/config/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Por favor ingrese su correo electrónico y contraseña para iniciar sesión',
                    style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (value) {
                      // FocusScope.of(context).requestFocus(focusPassword);
                    },
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.visibility_off_outlined,
                          color: AppTheme.unselectedColor,
                        ),
                      ),
                    ),
                    obscureText: true,
                    obscuringCharacter: '●',
                  ),
                  const Spacer(flex: 1),
                  Align(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        '¿Olvido su contraseña?',
                        style: TextStyle(
                          color: AppTheme.firstColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.firstColor,
                        disabledBackgroundColor:
                            AppTheme.firstColor.withOpacity(0.2),
                        disabledForegroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(
                          color: AppTheme.unselectedColor,
                          fontSize: 16,
                          fontWeight: null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
