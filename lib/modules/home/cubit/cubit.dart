import 'package:chat/models/post/solid_post.dart';
import 'package:chat/modules/home/cubit/states.dart';
import 'package:chat/utils/streamers/post_streamer/post_downloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeScreenCubit extends Cubit<HomeScreenStates>{

  static List<Post> posts = [];

  HomeScreenCubit():super(HomeScreenInitialState()){
    getCommunityPosts();
  }

  static HomeScreenCubit getCubit(BuildContext context)=>BlocProvider.of(context);

  Future<void> getCommunityPosts()async{

    posts = [];

    emit(HomeScreenLoadingState());

    await PostDownloader.getAllPosts().then((value) {
      posts = value;
      emit(HomeScreenGotPostsState());
    }).catchError((error){
      debugPrint('error in home screen while getting community posts: $error');
      emit(HomeScreenErrorState());
    });
  }

}