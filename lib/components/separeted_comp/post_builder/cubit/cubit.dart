
import 'package:chat/components/separeted_comp/post_builder/cubit/states.dart';
import 'package:chat/models/post/solid_post.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/streamers/post_like_maker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PostCubit extends Cubit<PostStates>{

  PostCubit():super(PostInitialState());

  static PostCubit getCubit(context)=> BlocProvider.of(context);

  void toggleLikeState({required Post post}){

    // locally handle the like
    if(post.peopleWhoLikes.contains(CurrentUser.user.uId)){
      post.peopleWhoLikes.remove(CurrentUser.user.uId);
    }
    else{
    post.peopleWhoLikes.add(CurrentUser.user.uId!);
    }
    emit(PostChangeLikeState());

    // now, take your time to toggle it in the back-end
    PostLikeMaker.makeLike(post: post);

  }


}