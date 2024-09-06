import 'package:chat/models/post/solid_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class PostLikeMaker {
  static void makeLike({required Post post}) async {

    List peopleWhoLikes = post.peopleWhoLikes;

    await FirebaseFirestore.instance.collection('posts').doc(post.authorId).collection('postsList').doc(post.id)
        .update({'peopleWhoLikes' : peopleWhoLikes });
  }
}
