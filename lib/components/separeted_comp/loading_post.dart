import 'package:flutter/material.dart';

class LoadingPosts extends StatelessWidget {
  const LoadingPosts({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context , index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Container(
                height: 50,

                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 25,
                    ),
                    SizedBox(width: 20,),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  )
              )
            ],
          ),
        );
      },
    );
  }
}
