import 'package:flutter/cupertino.dart';

final class SignInClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    
    Path path = new Path();
    double w = size.width;
    double h = size.height;

    path.cubicTo(.4*w,.85*h,0.75*w,.3*h,w ,h);
    path.lineTo(w,0);
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
  
}