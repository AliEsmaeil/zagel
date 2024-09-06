import 'package:chat/models/post/image_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostZoomer extends StatefulWidget {
  static const route = 'POST_ZOOMER';
  PostZoomer({super.key,});

  @override
  State<PostZoomer> createState() => _PostZoomerState();
}

class _PostZoomerState extends State<PostZoomer> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    ImagePost post = ModalRoute.of(context)?.settings.arguments as ImagePost;
    return GestureDetector(
      onTap: (){
        setState(() {
          visible = !visible;
        });
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.vertical,
        onDismissed: (direction)=>Navigator.of(context).pop(),
        child: Scaffold(
            backgroundColor: Colors.black,
          body: SafeArea(
            minimum: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.network(post.imageLink,fit: BoxFit.cover,),
                    if(visible)
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3) ,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                   '  at: ${post.date.substring(11)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  post.text,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                      )
                  ],
                ),
                Placeholder(
                  fallbackHeight: 50,
                  fallbackWidth: double.infinity,
                  color: Colors.transparent,
                  child: (visible)? Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red,),
                      SizedBox(width: 5,),
                      Text(
            '${post.peopleWhoLikes.length} Likes',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
                      ),
                      Spacer(),
                      Icon(Icons.comment_rounded, color: Colors.pink.shade300,),
                      SizedBox(width: 5,),
                      Text(
            '80 Comments',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
                      ),
                    ],
                  ),
                ): null,
                )
              ],
            )
          ),

        ),
      ),
    );
  }
}


