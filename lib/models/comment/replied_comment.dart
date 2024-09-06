import 'package:chat/models/comment/base_comment.dart';

class RepliedComment extends BaseComment {
  late List<BaseComment> replies = [];

  RepliedComment(
      {required super.text,
      required super.date,
      required super.authorId,
      required super.peopleWhoLikes,
      required this.replies});

  RepliedComment.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
   if(json['replies'].isNotEmpty){

       json['replies'].forEach((reply) {
         replies.add(BaseComment.fromJson(reply));

       });

   }
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();

    List<Map<String, dynamic>> json = [];

    replies.forEach((reply) {
      json.add(reply.toJson());
    });
    map['replies'] = json;

    return map;
  }
}
