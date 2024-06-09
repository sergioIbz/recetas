import 'package:flutter/material.dart';
import 'package:recetas/presentation/screens/widgets/custom_button.dart';
import 'package:recetas/presentation/screens/widgets/custom_text.dart';
import 'package:recetas/presentation/screens/widgets/custom_title.dart';
import 'package:recetas/presentation/screens/widgets/margin.dart';

class RegisterScreen extends StatelessWidget {
  static const name = 'register-screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Margin(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),
          const CustomTitle('Crear cuenta'),
          const SizedBox(height: 30),
          const CustomSubTitle(
            'Ingresa tu correo electrónico y contraseña.',
          ),
          const SizedBox(height: 40),
          const CustomTextField(
            labelText: 'Nombre usuario',
          ),
          const SizedBox(height: 40),
          const CustomTextField(
            labelText: 'Correo',
          ),
          const SizedBox(height: 40),
          const CustomTextField(
            isPassword: true,
            labelText: 'Contraseña',
          ),
          const SizedBox(height: 40),
          const CustomTextField(
            isPassword: true,
            labelText: 'Confirmar contraseña',
          ),
          const Spacer(),
          CustomButton(
            text: 'Registrar',
            onPressed: () {},
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
