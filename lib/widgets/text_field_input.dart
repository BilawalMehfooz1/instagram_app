import 'package:flutter/material.dart';
import 'package:instagram_app/Screens/auth_screens/login_screen.dart';
import 'package:instagram_app/data/colors.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key,
    this.obscureText = false,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
    this.isFocusedCallback,
    required this.textEditingController,
  });

  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(bool)? isFocusedCallback;
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
      // Call the callback function to update isTextFocused
      widget.isFocusedCallback!(_isFocused);
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
        cursorColor: primaryColor,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          // filled: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            top: 10,
            left: 12,
            right: 12,
            bottom: 26,
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
