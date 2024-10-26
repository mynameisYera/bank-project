import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';

class MessageInputField extends StatelessWidget {
  final String? Function(String?)? validator;
  final VoidCallback onPressed;
  final TextEditingController? controller;
  final Key formKey;

  const MessageInputField(
      {Key? key,
      this.validator,
      required this.onPressed,
      required this.controller,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Write your message',
          hintStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[800],
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.send,
              color: AppColors.buttonColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
