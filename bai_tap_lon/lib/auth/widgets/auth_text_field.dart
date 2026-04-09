import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}