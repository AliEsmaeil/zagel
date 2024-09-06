import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const  SizedBox(
      width: 30,
      height: 30,
      child:  CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(216,27,100,1)),
        strokeCap: StrokeCap.round,
       // backgroundColor: Colors.orange,
        strokeWidth: 2,
      ),
    );
  }
}
