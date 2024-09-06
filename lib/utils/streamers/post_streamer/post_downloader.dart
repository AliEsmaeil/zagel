import 'package:chat/models/post/image_post.dart';
import 'package:chat/models/post/solid_post.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/date_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class PostDownloader {

  static Future<List<Post>> getCurrentUserPosts() async {

    List<Post> posts = [];

    var value = await FirebaseFirestore.instance
        .collection('posts')
        .doc(CurrentUser.user.uId)
        .collection('postsList')
        .get();

    List data = value.docs;
    data.sort(
            (a,b)=> DateTime(1).getFormatter.parse(b['date'])
            .compareTo(DateTime(1).getFormatter.parse(a['date']))
    ); // compareTo is added by extension method


    for (var element in data) {
      var map = element.data();
      map['id'] = element.id;
      map['authorId'] = CurrentUser.user.uId;
      (element.data().keys.contains('imageLink'))?
      posts.add(ImagePost.fromJson(map)):
      posts.add(Post.fromJson(map));
    }
    print('posts from the streamer : $posts');
    return posts;

  }

  static Future<List<Post>> getAllPosts() async {

    List<Post> posts = [];

     await FirebaseFirestore.instance.collectionGroup('postsList').get().then((value){
       value.docs.forEach((post) {

         var map = post.data();

         map['id'] = post.id;
         map['authorId'] = post.reference.parent.parent?.id;
         print('post is : $map');
         posts.add(
           post.data().keys.contains('imageLink')?
               ImagePost.fromJson(map):
               Post.fromJson(map),
         );
       });

    }).catchError((error, st){
      print('error getting all posts $error , $st');
     });

     posts.sort((a,b)=> DateTime(1).getFormatter.parse(b.date)
         .compareTo(DateTime(1).getFormatter.parse(a.date)));
    return posts;
  }
}

extension DateComparison on DateTime{

  int compareTo(DateTime other)=>(isAfter(other))? 1 : -1;
}