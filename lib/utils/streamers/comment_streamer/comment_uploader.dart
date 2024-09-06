import 'package:chat/models/post/solid_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class CommentUploader {
  static void uploadComment({required Post post,}) async{

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post.authorId)
        .collection('postsList')
        .doc(post.id)
        .update({
      'comments': post.comments.map((e) => e.toJson()),
    }).catchError((error, st){
      print('error uploading comment $error , $st');
    });
  }
}
