import 'package:chat/components/separeted_comp/loading_post.dart';
import 'package:chat/components/separeted_comp/post_builder/post_builder.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/create_post/create_post_screen.dart';
import 'package:chat/modules/profile/cubit/cubit.dart';
import 'package:chat/modules/profile/cubit/states.dart';
import 'package:chat/modules/profile/edit/edit_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const route = 'PROFILE_SCREEN';
  final UserModel user = CurrentUser.user;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  ProfileScreenCubit()..getUserPosts(),
      child: BlocBuilder<ProfileScreenCubit, ProfileScreenStates>(

          builder: (context, state) {
            var cubit = ProfileScreenCubit.getCubit(context);
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 275,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: user.cover == null
                                        ? NetworkImage(
                                            'https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg')
                                        : NetworkImage(user.cover!),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  radius: 78,
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundImage: user.image == null
                                        ? NetworkImage(
                                            'https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg')
                                        : NetworkImage(user.image!),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Text(
                        '${user.name}',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                      ),
                      Text(
                        '${user.bio}',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () {},
                                      highlightColor: Colors.grey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Posts',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            '100',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () {},
                                      highlightColor: Colors.grey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Followers',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            '2k',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () {},
                                      highlightColor: Colors.grey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Following',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            '95',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () {},
                                      highlightColor: Colors.grey,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Pics',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            '33',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(CreatePostScreen.route);
                                    },
                                    child: Text('Add Photos'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(EditProfileScreen.route);
                                    },
                                    label: Text('Edit'),
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition: cubit.posts.isNotEmpty,
                        builder: (context) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                PostBuilder(post: cubit.posts[index]),
                            itemCount: cubit.posts.length,
                          );
                        },
                        fallback: (context) => LoadingPosts(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
