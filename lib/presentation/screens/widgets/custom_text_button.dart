import 'package:flutter/material.dart';
import 'package:recetas/config/theme/app_theme.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final AlignmentGeometry alignment;
  final void Function()? onPressed;

  const CustomTextButton({
    required this.text,
    this.color = AppTheme.unselectedColor,
    this.alignment = Alignment.center,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
