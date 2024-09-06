import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget commentChattingTF({
  Function(String?)? onChanged,
  TextEditingController? controller,
  bool autoFocus = false,
  ScrollController? scrollController,
  FocusNode? focusNode,
  VoidCallback? onTap,
  Function(String?)? onSubmitted,
  required String hintText,
  required BuildContext context,
  Widget? prefixIcon,
}) =>
    TextFormField(
      controller: controller,
      onChanged: onChanged,
      autofocus: autoFocus,
      scrollController: scrollController,
      focusNode: focusNode,
      onTap: onTap,
      onFieldSubmitted: onSubmitted,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      maxLines: null,
      scrollPhysics: NeverScrollableScrollPhysics(),
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.all(8),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade100
              : Colors.grey,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade200
                    : Colors.grey.shade500,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade200
                    : Colors.grey.shade500,
              ))),
    );
