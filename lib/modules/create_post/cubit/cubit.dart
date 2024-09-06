import 'dart:io';

import 'package:chat/core/constants/post_access.dart';
import 'package:chat/models/post/image_post.dart';
import 'package:chat/models/post/solid_post.dart';
import 'package:chat/modules/create_post/cubit/states.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/date_utilities.dart';
import 'package:chat/utils/image_picker.dart';
import 'package:chat/utils/streamers/image_uploader.dart';
import 'package:chat/utils/streamers/post_streamer/post_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

final class CreatePostScreenCubit extends Cubit<CreatePostScreenStates> {
  Widget selected = Row(children: [
    Icon(
      Icons.language,
      color: Colors.blue,
    ),
    SizedBox(
      width: 10,
    ),
    Text('Public'),
  ]);

  File? image;

  PostAccess access = PostAccess.PUBLIC;

  CreatePostScreenCubit() : super(CreatePostScreenInitialState());

  static CreatePostScreenCubit getCubit(context) => BlocProvider.of(context);

  void changePopupMenuChild(PostAccess v) {
    access = v;
    // switch expression
    selected = switch(v){
      PostAccess.PUBLIC=>Row(children: [
        Icon(
          Icons.language,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Public'),
      ]),
      PostAccess.FRIENDS=>Row(children: [
        Icon(
          Icons.supervised_user_circle,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Friends'),
      ]),
      PostAccess.PRIVATE=>Row(children: [
        Icon(
          Icons.account_circle_rounded,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Private'),
      ]),
    };
    emit(CreatePostScreenPopupChangedState());
  }

  void pickImage(ImageSource source) async {
    image = await MyImagePicker.pickImage(source);

    if (image != null) {
      emit(CreatePostScreenImagePickedState());
    }
  }

  void postTextChanged() {
    emit(CreatePostScreenTextChangedState());
  }

  void uploadPost({
    required String text,
  }) async {
    emit(CreatePostLoadingState());
    try {
      if (image == null) {
        PostUploader(
                post: Post(
                    text: text,
                    date: DateTime(1).getFormatter.format(DateTime.now()).toString(),
                    access: access))
            .uploadPost();
      } else {
        String link = await ImageUploader(image: image!)
            .uploadImage(storagePath: 'postImages/${CurrentUser.user.uId}');

        PostUploader(
                post: ImagePost(
                    text: text,
                    date: DateTime(1).getFormatter.format(DateTime.now()).toString(),
                    access: access,
                    imageLink: link))
            .uploadPost();
      }

      emit(CreatePostSuccessfulUploadState());
    } on Error catch (e) {
      debugPrint('error uploading post $e');
      emit(CreatePostFailedUploadState());
    } on Exception catch (e) {
      debugPrint('Exception Uploading post $e');
      emit(CreatePostFailedUploadState());
    } catch (e) {
      debugPrint('Something went wrong in uploading post $e');
      emit(CreatePostFailedUploadState());
    }
  }

  void removePostImage(){
    image = null;
    emit(CreatePostRemoveImageState());
  }
}
