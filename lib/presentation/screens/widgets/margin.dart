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
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SizedBox(
          height: height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
