import 'package:chat/models/chat/chat_room.dart';
import 'package:chat/models/chat/message.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/date_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatStreamer{

  static Future<(bool chatted,String? roomId)> hasChattedBefore({required String chatUserId})async{

    Set partners = {CurrentUser.user.uId , chatUserId};
    bool chatted = false;
    String? roomId;

    await FirebaseFirestore.instance.collection('chatRooms').get().then((value){

      if(value.docs.isNotEmpty) {

        value.docs.forEach((room) {

          if(partners.containsAll(room['partners']));
           {
             chatted = true;
             roomId = room.id;
           }
        });
      }
    });
    return (chatted,roomId);
  }

  static Stream getChat({required String roomId})async*{
// must return a stream to listen to its changes

  yield FirebaseFirestore.instance.collection('chatRooms').doc(roomId).snapshots();
  }

  static Future<bool> sendMessage({required String roomId, required String message})async{

    late ChatRoom chatRoom;

    await FirebaseFirestore.instance.collection('chatRooms').doc(roomId).get().then((value) {
     chatRoom = ChatRoom.fromJson(value.data()!);
    });

    print('message is : $message');

    var tempMessage = Message(from: CurrentUser.user.uId!,
        to: chatRoom.partners.where((e) => e != CurrentUser.user.uId ).single,
        date: DateTime(1).getFormatter.format(DateTime.now()),
        message: message,
    );

    chatRoom.messages.add(tempMessage);
    print('chat room messages : ${chatRoom.messages}');
    print(chatRoom.toJson);
    await FirebaseFirestore.instance.collection('chatRooms').doc(roomId).update(chatRoom.toJson);

    await FirebaseFirestore.instance.collection('chatRooms').doc(roomId).get().then((value) {
      if(value.data()!['messages'].contains(tempMessage)) {
        return true;
      }
    });
    print('added');
    return false;
}

/// returns chatRoom id and if there's no a room, it creates one and returns its Id.
  ///
static Future<String> getChatRoomId ({required String chatUserId})async{

    String roomId = '';

    ChatRoom chatRoom = ChatRoom(
      partners: [CurrentUser.user.uId!, chatUserId ],
    );

    var result = await FirebaseFirestore.instance.collection('chatRooms').where(
      'partners',
      arrayContains: chatRoom.partners,
    ).get();

    if(result.docs.isNotEmpty){
      roomId = result.docs.first.id;
    }
    else{
      await FirebaseFirestore.instance.collection('chatRooms').add(chatRoom.toJson).then((value) {
        roomId = value.id;
      });
    }
    // it's an empty room until now, it will not be created until the user attempts to send a message
  return roomId;
}

}