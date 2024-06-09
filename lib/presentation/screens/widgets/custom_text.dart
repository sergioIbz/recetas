import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 22),
      obscureText: widget.isPassword && isObscureText,
      decoration: InputDecoration(
        errorText:
            widget.errorText?.isNotEmpty ?? false ? widget.errorText : null,
        errorStyle: const TextStyle(fontSize: 15),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() {
                  isObscureText = !isObscureText;
                }),
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
      onChanged: widget.onChanged,
    );
  }
}
