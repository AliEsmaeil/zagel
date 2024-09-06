import 'package:chat/core/constants/post_access.dart';
import 'package:chat/models/comment/replied_comment.dart';

base class Post {
  late String id;
  late String authorId;
  late List<RepliedComment> comments = [];
  String text;
  String date;
  PostAccess access;
  List<String> peopleWhoLikes = [];

  Post({required this.text, required this.date, required this.access});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        authorId = json['authorId'],
        text = json['text'],
        date = json['date'],
        access = PostAccess.values.byName(json['access'])
  {
    json['peopleWhoLikes'].forEach((e) {
      peopleWhoLikes.add(e);
    });
    if(json['comments'].isNotEmpty)
      {
        json['comments'].forEach((comment){
          comments.add(RepliedComment.fromJson(comment));
        });
      }
  }

  Map<String, dynamic> toJson(){

    var json = {
      'text': text,
      'date': date,
      'access': access.name,
      'peopleWhoLikes': peopleWhoLikes,
    };
    List<Map<String,dynamic>> jsonCommentsList = [];

    comments.forEach((comment) {
      jsonCommentsList.add(comment.toJson());
    });

    json['comments'] = jsonCommentsList;

    return json;
  }

  String get image => '';
}
