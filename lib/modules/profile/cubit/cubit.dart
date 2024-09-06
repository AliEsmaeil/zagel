import 'package:chat/models/post/solid_post.dart';
import 'package:chat/modules/profile/cubit/states.dart';
import 'package:chat/utils/streamers/post_streamer/post_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ProfileScreenCubit extends Cubit<ProfileScreenStates> {
  List<Post> posts = [];

  ProfileScreenCubit() : super(ProfileScreenInitialState());

  static ProfileScreenCubit getCubit(context) => BlocProvider.of(context);

  void getUserPosts() async {
    emit(ProfileScreenLoadingState());
    print('get user posts called!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

    try {
      posts = await PostDownloader.getCurrentUserPosts();
      print('inside the try and before emit');
      emit(ProfileScreenGotPostsState());
    }
    catch(e){
      emit(ProfileScreenErrorState());
      throw e;
    }
  }
}
