import 'package:chat/modules/messaging_screen/cubit/states.dart';
import 'package:chat/modules/messaging_screen/messaging_screen.dart';
import 'package:chat/utils/streamers/chat_streamer/chat_streamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class MessagingScreenCubit extends Cubit<MessagingScreenStates>{

  MessagingScreenCubit():super(MessagingScreenInitialState());

  static MessagingScreenCubit getCubit(context)=>BlocProvider.of(context);

  void changeMessageText()=>emit(MessagingScreenMessageChangedState());

  void sendMessage({required String message, required String roomId}) async{
print('room id in send message : $roomId');
    await ChatStreamer.sendMessage(roomId: roomId, message: message).then((value) {

      emit(MessagingScreenSentMessageState());
    });

  }

  void getRoom({required String chatUserId})async{

    MessagingScreen.roomId = await ChatStreamer.getChatRoomId(chatUserId: chatUserId);
    print('room id = ${MessagingScreen.roomId}');

  }
}