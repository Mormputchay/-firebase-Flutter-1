import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final String? helperText;
  final Widget prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? right;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  const RoundTextField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.helperText,
      this.validator,
      required this.obscureText,
      required this.prefixIcon,
      this.right,
      this.onFieldSubmitted,
      this.focusNode,
      this.inputFormatters});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
          helperText: helperText,
          suffixIcon: right,
          prefixIcon: prefixIcon),
      validator: validator,
    );
  }
}
