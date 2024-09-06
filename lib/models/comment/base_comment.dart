

class BaseComment {
  String text;
  String date;
  String authorId;
  List peopleWhoLikes;

  BaseComment(
      {required this.text,
      required this.date,
      required this.authorId,
      required this.peopleWhoLikes});

  BaseComment.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        date = json['date'],
        authorId = json['authorId'],
        peopleWhoLikes = json['peopleWhoLikes'];

  Map<String,dynamic> toJson()=>{
    'text' : text,
    'date' : date,
    'authorId': authorId,
    'peopleWhoLikes': peopleWhoLikes,
  };
}
