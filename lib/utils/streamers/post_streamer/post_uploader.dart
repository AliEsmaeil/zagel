import 'package:chat/models/post/solid_post.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class PostUploader {
  final Post post;

  PostUploader({required this.post});

  void uploadPost() async{
   await FirebaseFirestore.instance
        .collection('posts')
        .doc(CurrentUser.user.uId)
        .collection('postsList')
        .add(post.toJson());
  }
}
