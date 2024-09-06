import 'package:chat/models/post/solid_post.dart';

final class ImagePost extends Post{

  String imageLink;

  ImagePost({required this.imageLink, required super.text, required super.date, required super.access});

  ImagePost.fromJson(Map<String,dynamic> json):
      imageLink = json['imageLink'],
        super.fromJson(json);

  @override
  Map<String,dynamic>  toJson(){

    var json = super.toJson();
    json['imageLink'] = imageLink;
    return json;

  }

  @override
  String get image => imageLink;


}