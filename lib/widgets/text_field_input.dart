import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    this.obscureText = false,
    required this.keyboardType,
    required this.hintText,
    required this.textEditingController,
  });

  final bool obscureText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
