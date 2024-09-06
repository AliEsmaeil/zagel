import 'package:chat/components/separeted_comp/loading_post.dart';
import 'package:chat/components/separeted_comp/post_builder/post_builder.dart';
import 'package:chat/modules/create_post/create_post_screen.dart';
import 'package:chat/modules/home/cubit/cubit.dart';
import 'package:chat/modules/home/cubit/states.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {

  PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {


        return Column(
          children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(CreatePostScreen.route);
                    },
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.green,
                                size: 22,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsetsDirectional.all(5),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1, color: Colors.black26),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text('What\'s in your mind...'),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundImage: CurrentUser.user.image == null
                                    ? NetworkImage(
                                        'https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg')
                                    : NetworkImage(CurrentUser.user.image!),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! HomeScreenLoadingState,
                      builder: (context) => ListView.builder(
                        itemCount: HomeScreenCubit.posts.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print('index is = $index');
                          print(HomeScreenCubit.posts.length);
                          return PostBuilder(post: HomeScreenCubit.posts[index]);
                        },
                      ),
                      fallback: (context) => LoadingPosts(),
                    ),
                  ),
                ],
        );
      },
    );
  }
}
