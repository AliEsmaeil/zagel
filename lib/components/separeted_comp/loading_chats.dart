import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingChats extends StatelessWidget {
  const LoadingChats({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemBuilder: (context,index)=>Container(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade100,
            ),
            SizedBox(width: 20,),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
