import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
enum ToastState{
  SUCESS,
  ERROR,
  WARNING,
}

void showCustomToast({required String message ,required ToastState status})=>
    Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
      backgroundColor: getToastColor(status),
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );

Color getToastColor(ToastState status){
   switch(status){
    case ToastState.SUCESS:
      return Colors.green;
    case ToastState.ERROR:
      return Colors.red;
    default: return Colors.orange;

  }
}