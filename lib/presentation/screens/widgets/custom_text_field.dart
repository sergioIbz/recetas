import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recetas/presentation/screens/providers/obscure_text_provider.dart';

class CustomTextField extends ConsumerWidget {
  final String? errorText;
  final String? labelText;
  final bool isPassword;
  final Function(String)? onChanged;
  const CustomTextField({
    this.isPassword = false,
    this.labelText,
    this.errorText,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscureText = ref.watch(obscureTextProvider);
    return TextField(
      style: const TextStyle(fontSize: 22),
      obscureText: isPassword && isObscureText,
      decoration: InputDecoration(
        errorText: errorText?.isNotEmpty ?? false ? errorText : null,
        errorStyle: const TextStyle(fontSize: 15),
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () => ref
                    .read(
                      obscureTextProvider.notifier,
                    )
                    .update(
                      (state) => !state,
                    ),
                icon: Icon(
                  isObscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 28,
                ),
              )
            : null,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
    );
  }
}
