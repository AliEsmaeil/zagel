import 'package:chat/models/comment/base_comment.dart';
import 'package:chat/models/comment/replied_comment.dart';
import 'package:chat/models/post/solid_post.dart';
import 'package:chat/modules/comments_screen/cubit/states.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/date_utilities.dart';
import 'package:chat/utils/streamers/comment_streamer/comment_uploader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CommentsScreenCubit extends Cubit<CommentsScreenStates>{

  CommentsScreenCubit():super(CommentsScreenInitialState());

  static CommentsScreenCubit getCubit(context)=>BlocProvider.of(context);

  void likeComment({required Post post, required int index, replyIndex = -1})async{
    //  make like to a parent comment
    if(replyIndex == -1){

      if(post.comments[index].peopleWhoLikes.contains(CurrentUser.user.uId)){
        post.comments[index].peopleWhoLikes.remove(CurrentUser.user.uId);
      }
      else{
        post.comments[index].peopleWhoLikes.add(CurrentUser.user.uId);
      }
    }
    // make like to child comment
    else{


      if(post.comments[index].replies[replyIndex].peopleWhoLikes.contains(CurrentUser.user.uId)){
        post.comments[index].replies[replyIndex].peopleWhoLikes.remove(CurrentUser.user.uId);
      }
      else{
        post.comments[index].replies[replyIndex].peopleWhoLikes.add(CurrentUser.user.uId);
      }
    }
    emit(CommentsScreenLikeCommentState());

    CommentUploader.uploadComment(post: post);
  }


  void postComment({required Post post, required String comment})async{

    var tempComment = RepliedComment(
        text: comment,
        date: DateTime(1).getFormatter.format(DateTime.now()).toString(),
        authorId: CurrentUser.user.uId!,
        peopleWhoLikes: [],
        replies: []
    );
    post.comments.add(tempComment);

    emit(CommentsScreenPostCommentState());

     CommentUploader.uploadComment(post: post);

  }

  void replyToComment({required Post post, required int commentIndex, required String reply, commentReplyIndex = -1}) {

    var replyComment = BaseComment(
        text: reply.substring(reply.indexOf('.')),
        date: DateTime(1).getFormatter.format(DateTime.now()),
        authorId: CurrentUser.user.uId!,
        peopleWhoLikes: [],
    );

    if(commentReplyIndex != -1){
      post.comments[commentIndex].replies.insert(commentReplyIndex, replyComment);
    }
    else{
      post.comments[commentIndex].replies.add(replyComment);
    }
    emit(CommentsScreenReplyCommentState());

    CommentUploader.uploadComment(post: post);
  }

}