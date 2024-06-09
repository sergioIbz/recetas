import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_theme.dart';
import '../../providers/login_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/margin.dart';
import '../register/register_screen.dart';

class LoginScreen extends ConsumerWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    final isValid = ref.watch(loginStateProvider.notifier).isValid();
    final loginProvider = ref.watch(loginStateProvider);
    final textUpdate = ref.read(loginStateProvider.notifier);

    return Scaffold(
     
      body: Margin(
        height: height,
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
              errorText: loginProvider.email.error,
              onChanged: textUpdate.changeEmail,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              isPassword: true,
              labelText: 'Contraseña',
              errorText: loginProvider.password.error,
              onChanged: textUpdate.changePassword,
            ),
            const Spacer(flex: 1),
            CustomTextButton(
              text: '¿Olvido su contraseña?',
              color: AppTheme.firstColor,
              onPressed: () {},
            ),
            const Spacer(flex: 2),
            CustomButton(
              text: 'Ingresar',
              isValid: isValid,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              text: '¿No tienes cuenta?',
              onPressed: () => context.pushNamed(RegisterScreen.name),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
