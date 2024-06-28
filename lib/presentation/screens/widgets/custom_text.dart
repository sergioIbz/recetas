import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final String? labelText;
  final bool isPassword;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    this.isPassword = false,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      style: const TextStyle(fontSize: 22),
      obscureText: widget.isPassword && isObscureText,
      decoration: InputDecoration(
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
      validator: widget.validator,
    );
  }
}
