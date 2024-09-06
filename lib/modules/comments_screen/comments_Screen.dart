import 'package:chat/components/comment-chatting_TF.dart';
import 'package:chat/models/post/solid_post.dart';
import 'package:chat/modules/comments_screen/cubit/cubit.dart';
import 'package:chat/modules/comments_screen/cubit/states.dart';
import 'package:chat/modules/likes_screen/likes_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/date_utilities.dart';
import 'package:chat/utils/social_icons.dart';
import 'package:chat/utils/streamers/post_author_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//ignore: must_be_immutable
class CommentsScreen extends StatelessWidget {
  static const route = 'COMMENTS_SCREEN';
  final commentController = TextEditingController();
  final commentFocusNode = FocusNode();
  int commentIndex = -1;
  int commentReplyIndex = -1;
  late Post post;
  final scrollController = ScrollController();

  CommentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    post = ModalRoute.of(context)!.settings.arguments as Post;

    return BlocProvider(
      create: (context) => CommentsScreenCubit(),
      child: BlocBuilder<CommentsScreenCubit, CommentsScreenStates>(
        builder: (context, state) {
          var cubit = CommentsScreenCubit.getCubit(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
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
                          Text(post.peopleWhoLikes.length.toString()),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: (post.comments.isNotEmpty)
                        ? Scrollbar(
                            child: ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: post.comments.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: AuthorDetailsGetter(
                                          userId: post.comments[index].authorId)
                                      .getAuthor(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    snapshot.data!.image),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.grey
                                                                    .shade100
                                                                : Colors.grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                    .data!.name,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge
                                                                    ?.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                              ),
                                                              Text(
                                                                post
                                                                    .comments[
                                                                        index]
                                                                    .text,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (post
                                                            .comments[index]
                                                            .peopleWhoLikes
                                                            .isNotEmpty)
                                                          Positioned(
                                                            top: 10,
                                                            right: 10,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(context).pushNamed(
                                                                    LikesScreen
                                                                        .route,
                                                                    arguments: post
                                                                        .comments[
                                                                            index]
                                                                        .peopleWhoLikes);
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    post
                                                                        .comments[
                                                                            index]
                                                                        .peopleWhoLikes
                                                                        .length
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Icon(
                                                                    Social
                                                                        .thumbs_up,
                                                                    color: Colors
                                                                        .blue
                                                                        .shade600,
                                                                    size: 15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            DateTime(1)
                                                                .getFormatter
                                                                .parse(post
                                                                    .comments[
                                                                        index]
                                                                    .date)
                                                                .since(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.reply,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          onPressed: () {
                                                            commentController
                                                                    .text =
                                                                '${snapshot.data!.name}.';
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    commentFocusNode);
                                                            commentIndex =
                                                                index;
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            post.comments[index]
                                                                    .peopleWhoLikes
                                                                    .contains(
                                                                        CurrentUser
                                                                            .user
                                                                            .uId)
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border_rounded,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            cubit.likeComment(
                                                                post: post,
                                                                index: index);
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),

                                          // replies//////////
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: post
                                                .comments[index].replies.length,
                                            itemBuilder: (context, replyIndex) {
                                              return FutureBuilder(
                                                  future: AuthorDetailsGetter(
                                                          userId: post
                                                              .comments[index]
                                                              .replies[
                                                                  replyIndex]
                                                              .authorId)
                                                      .getAuthor(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }
                                                    if (snapshot.hasData) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                30, 8, 0, 8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 20,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      snapshot
                                                                          .data!
                                                                          .image),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                                child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Theme.of(context).brightness ==
                                                                                Brightness.light
                                                                            ? Colors.grey.shade100
                                                                            : Colors.grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data!.name,
                                                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                                  fontWeight: FontWeight.w400,
                                                                                ),
                                                                          ),
                                                                          Text(post
                                                                              .comments[index]
                                                                              .replies[replyIndex]
                                                                              .text),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    if (post
                                                                        .comments[
                                                                            index]
                                                                        .replies[
                                                                            replyIndex]
                                                                        .peopleWhoLikes
                                                                        .isNotEmpty)
                                                                      Positioned(
                                                                        top: 10,
                                                                        right:
                                                                            10,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushNamed(LikesScreen.route,
                                                                                arguments: post.comments[index].replies[replyIndex].peopleWhoLikes);
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                post.comments[index].replies[replyIndex].peopleWhoLikes.length.toString(),
                                                                                style: Theme.of(context).textTheme.bodySmall,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Icon(
                                                                                Social.thumbs_up,
                                                                                color: Colors.blue.shade600,
                                                                                size: 15,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        DateTime(1)
                                                                            .getFormatter
                                                                            .parse(post.comments[index].replies[replyIndex].date)
                                                                            .since(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              color: Colors.grey,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .reply,
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        commentController.text =
                                                                            '${snapshot.data!.name}.';
                                                                        FocusScope.of(context)
                                                                            .requestFocus(commentFocusNode);
                                                                        commentIndex =
                                                                            index;
                                                                        commentReplyIndex =
                                                                            replyIndex;
                                                                      },
                                                                    ),
                                                                    IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        post.comments[index].replies[replyIndex].peopleWhoLikes.contains(CurrentUser.user.uId)
                                                                            ? Icons.favorite
                                                                            : Icons.favorite_border_rounded,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        cubit.likeComment(
                                                                            post:
                                                                                post,
                                                                            index:
                                                                                index,
                                                                            replyIndex:
                                                                                replyIndex);
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              30, 10, 0, 8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors
                                                                .grey.shade100
                                                            : Colors.grey,
                                                      ),
                                                    );
                                                  });
                                            },
                                          )
                                          // replies//////////
                                        ],
                                      );
                                    }

                                    /// if snapshot has data

                                    return Container(
                                      width: double.infinity,
                                      height: 150,
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor:
                                                Colors.grey.shade100,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Colors.grey.shade100,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                Icon(
                                  Social.comments,
                                  size: 100,
                                  color: Colors.grey.shade200,
                                ),
                                Text(
                                  'No Comments yet. Be the first',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: commentChattingTF(
                      context: context,
                      hintText: 'Write a comment',
                      controller: commentController,
                      autoFocus: true,
                      scrollController: scrollController,
                      focusNode: commentFocusNode,
                      onSubmitted: (comment) {
                        if (comment != null && comment.isNotEmpty) {
                          if (commentIndex != -1 &&
                              commentReplyIndex != -1) {
                            cubit.replyToComment(
                                post: post,
                                commentIndex: commentIndex,
                                reply: comment,
                                commentReplyIndex: commentReplyIndex + 1);
                          } else if (commentIndex == -1) {
                            cubit.postComment(post: post, comment: comment);
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn);
                          } else {
                            cubit.replyToComment(
                                post: post,
                                commentIndex: commentIndex,
                                reply: comment);
                          }
                        }
                        commentIndex = -1;
                        commentReplyIndex = -1;
                        commentController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
