import 'package:chat/models/chat/message.dart';

class ChatRoom{
  String? id;
  List<String> partners = [];
  List<Message> messages = [];

  ChatRoom({required this.partners});

  ChatRoom.fromJson(Map<String,dynamic> json){
    id = json['id'];
    json['partners'].forEach((p){
      partners.add(p);
    });
      json['messages'].forEach((message){
        messages.add(message);
      });

  }

 Map<String,dynamic> get toJson  =>{
    'id' : id ?? '',
   'partners' : partners,
  'messages' : messages,
  };
}