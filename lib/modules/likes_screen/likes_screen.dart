import 'package:chat/utils/social_icons.dart';
import 'package:chat/utils/streamers/post_author_details.dart';
import 'package:flutter/material.dart';

class LikesScreen extends StatelessWidget {
  static const route = 'LIKES_SCREEN';
  late final List fans;
  LikesScreen({super.key,});

  @override
  Widget build(BuildContext context) {

    fans = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      body: SafeArea( // safe area doesn't do its work
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Social.thumbs_up,
                      color: Colors.blue.shade600,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(fans.length.toString()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: fans.length,
                  padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 8),
                  itemBuilder: (context,index){
                    return FutureBuilder(
                      future: AuthorDetailsGetter(userId: fans[index]).getAuthor(),// he is a fan, who made like
                      builder: (context,snapshot){
                        if(snapshot.hasError)
                        {
                          return Text('Something went wrong');
                        }
                        else if(snapshot.hasData)
                        {
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            width: double.infinity,
                            height: 60,
                            child: Center(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data!.image),
                                    radius: 30,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    snapshot.data!.name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: double.infinity,
                          height: 75,
                          child: Center(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 30,
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
