import 'package:flutter/material.dart';

class Margin extends StatelessWidget {
  final double? height;
  final Widget? child;
  const Margin({
    this.height,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: child,
          )),
        ),
      ),
    );
  }
}
