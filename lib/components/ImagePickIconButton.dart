import 'package:flutter/material.dart';

class ImagePickIconButton extends StatelessWidget {
 final IconData icon;
  final VoidCallback? onPressed;

   const ImagePickIconButton({super.key,required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 20, color: Theme.of(context).scaffoldBackgroundColor,),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(.6)),
      ),

    );
  }
}
