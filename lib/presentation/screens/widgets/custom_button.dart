import 'package:flutter/material.dart';
import 'package:recetas/config/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isValid;
  final void Function()? onPressed;

  const CustomButton({
    required this.text,
    this.isValid = true,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.firstColor,
          disabledBackgroundColor: AppTheme.firstColor.withOpacity(0.2),
          disabledForegroundColor: Colors.white,
        ),
        onPressed: isValid ? onPressed : null,
        child:  Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
