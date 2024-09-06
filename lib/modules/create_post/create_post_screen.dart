import 'package:chat/components/ImagePickIconButton.dart';
import 'package:chat/core/constants/post_access.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/create_post/cubit/cubit.dart';
import 'package:chat/modules/create_post/cubit/states.dart';
import 'package:chat/modules/home/home_screen.dart';
import 'package:chat/modules/profile/profile_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatelessWidget {
  static const route = 'CREATE_POST_SCREEN';
  final UserModel user = CurrentUser.user;
  final textController = TextEditingController();

  final list = <PopupMenuItem>[
    PopupMenuItem(
      child: Row(children: [
        Icon(
          Icons.language,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Public', style: TextStyle(fontWeight: FontWeight.w300)),
      ]),
      value: PostAccess.PUBLIC,
    ),
    PopupMenuItem(
      child: Row(children: [
        Icon(
          Icons.supervised_user_circle,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Friends', style: TextStyle(fontWeight: FontWeight.w300)),
      ]),
      value: PostAccess.FRIENDS,
    ),
    PopupMenuItem(
      child: Row(children: [
        Icon(
          Icons.account_circle_rounded,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Private', style: TextStyle(fontWeight: FontWeight.w300)),
      ]),
      value: PostAccess.PRIVATE,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostScreenCubit(),
      child: BlocConsumer<CreatePostScreenCubit, CreatePostScreenStates>(
          listener: (context, state) {

            if(state is CreatePostSuccessfulUploadState){
              Navigator.of(context).pushReplacementNamed(ProfileScreen.route);
            }
          },
          builder: (context, state) {
            var cubit = CreatePostScreenCubit.getCubit(context);
            return Scaffold(
                appBar: AppBar(
                  scrolledUnderElevation: 0,
                  title: Text('Create Post'),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
                    },
                  ),
                  actions: [
                   if(textController.text.isNotEmpty || cubit.image != null)
                     Padding(
                       padding: EdgeInsetsDirectional.only(end: 10),
                       child: TextButton(
                         child:  Text('Post', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                           color: Colors.white,
                         ),),
                         style: const ButtonStyle(
                           backgroundColor: MaterialStatePropertyAll(
                               Colors.pink
                           ),
                         ),
                         onPressed: () {

                           cubit.uploadPost(text: textController.text,);

                         },
                       ),
                     ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if(state is CreatePostLoadingState)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: LinearProgressIndicator(),
                        ),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(user.image!),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                user.name!,
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
                            PopupMenuButton(
                              child: cubit.selected,
                              onSelected: (v) {
                                print('called');
                                cubit.changePopupMenuChild(v);
                              },
                              itemBuilder: (context) => list,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                cubit.pickImage(ImageSource.camera);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_photo_alternate,
                                  color: Colors.green),
                              onPressed: () {
                                cubit.pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                        Divider(),
                        Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            onChanged: (str){
                              textController.text = str;
                              cubit.postTextChanged();
                            },
                            decoration: InputDecoration(
                              hintText: 'Say Something',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        if (cubit.image != null)
                          Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              Image.file(cubit.image!),
                              ImagePickIconButton(icon: Icons.close_outlined,onPressed: (){
                                cubit.removePostImage();
                              },),
                            ],
                          )
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
