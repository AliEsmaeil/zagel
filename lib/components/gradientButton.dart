import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onTap;

  /// gradient to be used as a color for the button
  final LinearGradient gradient;
  final String text;
  final Size size;
  const GradientButton({
    super.key,
    this.onTap,
    required this.gradient,
    required this.text,
    this.size = const Size(double.infinity, 45),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
