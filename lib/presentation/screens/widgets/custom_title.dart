import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  const CustomTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomSubTitle extends StatelessWidget {
  final String text;
  const CustomSubTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
