import 'package:chat/modules/comments_screen/comments_Screen.dart';
import 'package:chat/modules/likes_screen/likes_screen.dart';
import 'package:chat/components/separeted_comp/post_builder/cubit/cubit.dart';
import 'package:chat/components/separeted_comp/post_builder/cubit/states.dart';
import 'package:chat/components/separeted_comp/post_zoomer.dart';
import 'package:chat/core/constants/post_access.dart';
import 'package:chat/models/post/image_post.dart';
import 'package:chat/models/post/solid_post.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/social_icons.dart';
import 'package:chat/utils/streamers/post_author_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBuilder extends StatelessWidget {
  final Post post;
  PostBuilder({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PostCubit(),
        child: BlocConsumer<PostCubit, PostStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = PostCubit.getCubit(context);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // author row

                        FutureBuilder(
                            future:
                                AuthorDetailsGetter(userId: post.authorId)
                                    .getAuthor(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(snapshot.data!.image),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Badge(
                                          backgroundColor: Colors.blue,
                                          alignment: Alignment.bottomRight,
                                          label: Icon(
                                            Icons.done,
                                            size: 8,
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              snapshot.data!.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          post.date,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.grey,
                                              ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      switch (post.access) {
                                        PostAccess.PUBLIC => Icons.language,
                                        PostAccess.FRIENDS =>
                                          Icons.supervised_user_circle,
                                        PostAccess.PRIVATE =>
                                          Icons.account_circle_rounded,
                                      },
                                      color: Colors.blue,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }
                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  )
                                ],
                              );
                            }),
                        Divider(
                          height: 15,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Text(
                          post.text,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (post is ImagePost)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(PostZoomer.route, arguments: post);
                            },
                            child: Container(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  post.image,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              if(post.peopleWhoLikes.isNotEmpty)
                              GestureDetector(
                                onTap: (){

                                      Navigator.of(context).pushNamed(LikesScreen.route, arguments: post.peopleWhoLikes);

                                  },
                                child: Row(
                                  children: [
                                    Text(
                                      '${post.peopleWhoLikes.length}',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(Social.thumbs_up, color: Colors.blue.shade600,),
                                  ],
                                ),
                              ),

                              Spacer(),
                              if(post.comments.isNotEmpty)
                              GestureDetector(
                                onTap: (){
                                    Navigator.of(context).pushNamed(CommentsScreen.route, arguments: post);

                                },
                                child: Row(
                                  children: [
                                    Text(
                                      post.comments.length.toString(),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(
                                      Social.comments,
                                      color: Colors.amber.shade800,
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),

                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: CurrentUser.user.image == null? NetworkImage('https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'):
                              NetworkImage(CurrentUser.user.image!),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  // display bottom sheet and allow user to write a comment
                                  Navigator.of(context).pushNamed(CommentsScreen.route, arguments: post);
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).brightness == Brightness.light ?
                                    Colors.grey.shade200 : Colors.grey,
                                    border: Border.all(color: Colors.grey.shade300,width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                        'Write a comment...',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  )
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                post.peopleWhoLikes
                                        .contains(CurrentUser.user.uId)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                cubit.toggleLikeState(post: post);
                              },
                            ),
                            Text(
                              'Like',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
