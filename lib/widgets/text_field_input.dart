import 'package:flutter/material.dart';
import 'package:instagram_app/data/colors.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    this.obscureText = false,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
    required this.textEditingController,
  });

  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _isFocused ? primaryColor : secondaryColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          alignLabelWithHint: true,
          filled: true,
          contentPadding: const EdgeInsets.only(
            top: 8,
            left: 12,
            right: 12,
            bottom: 24,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: _isFocused ? primaryColor : textColor,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        validator: widget.validator,
      ),
    );
  }
}
