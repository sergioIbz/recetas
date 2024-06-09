import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/presentation/screens/providers/register_provider.dart';
import 'package:recetas/presentation/screens/widgets/custom_button.dart';
import 'package:recetas/presentation/screens/widgets/custom_text.dart';
import 'package:recetas/presentation/screens/widgets/custom_title.dart';
import 'package:recetas/presentation/screens/widgets/margin.dart';

class RegisterScreen extends ConsumerWidget {
  static const name = 'register-screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerProvider = ref.watch(registerStateProvider);
    final textUpdate = ref.read(registerStateProvider.notifier);

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Margin(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                )),
            const SizedBox(height: 45),
            const CustomTitle('Crear cuenta'),
            const SizedBox(height: 30),
            const CustomSubTitle(
              'Ingresa tu correo electrónico y contraseña.',
            ),
            const SizedBox(height: 40),
            CustomTextField(
              labelText: 'Nombre usuario',
              errorText: registerProvider.userName.error,
              onChanged: textUpdate.changeUserName,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              labelText: 'Correo',
              errorText: registerProvider.email.error,
              onChanged: textUpdate.changeEmail,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              isPassword: true,
              labelText: 'Contraseña',
              errorText: registerProvider.password.error,
              onChanged: textUpdate.changePassword,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              isPassword: true,
              labelText: 'Confirmar contraseña',
              errorText: registerProvider.confirmPassword.error,
              onChanged: textUpdate.changeConfirmPassword,
            ),
            const Spacer(),
            CustomButton(
              text: 'Registrar',
              isValid: registerProvider.isValid(),
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
