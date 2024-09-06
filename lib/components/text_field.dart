import 'package:flutter/material.dart';

Widget CustomTextField({
  required TextEditingController controller,
  TextInputAction inputAction = TextInputAction.next,
  required TextInputType inputType,
  required String hintText,
  IconData? preIcon,
  bool beginFocused = false,
  String? Function(String?)? validator,
  Function(String?)? onSubmit,
  IconData? sufIcon,
  VoidCallback? onSufPressed,
  bool isPassword = false,
}) =>TextFormField(
      controller: controller,
      autofocus: beginFocused,
      maxLines:  inputType == TextInputType.multiline ? null : 1,
      textInputAction: inputAction,
      keyboardType: inputType,
      obscureText: isPassword,
      cursorWidth: 1,
      cursorColor: Colors.blue.shade700,
      style: TextStyle(
        fontSize: 15,
      ),
      validator: validator,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          preIcon,
          size: 16,
        ),
        suffixIcon: IconButton(
          onPressed: onSufPressed,
          icon: Icon(
            sufIcon,
            size: 16,
          ),
        ),
      ),
    );
