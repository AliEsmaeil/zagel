import 'package:chat/models/post_author.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthorDetailsGetter{

  String userId;
  AuthorDetailsGetter({required this.userId});



  Future<PostAuthor> getAuthor()async{
    PostAuthor author;

    return await FirebaseFirestore.instance.collection('users').doc(userId).get().then((value) {

      author = PostAuthor.fromJson(value.data()!);
      return author;
    }).catchError((error){
      print('error getting post author details: $error ');
    });
  }

}