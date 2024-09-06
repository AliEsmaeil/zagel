import 'package:chat/components/comment-chatting_TF.dart';
import 'package:chat/core/constants/gradient_color.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/messaging_screen/cubit/cubit.dart';
import 'package:chat/modules/messaging_screen/cubit/states.dart';
import 'package:chat/utils/gradient_text.dart';
import 'package:chat/utils/streamers/chat_streamer/chat_streamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingScreen extends StatelessWidget {
  static const route = 'MESSAGING_SCREEN';
  final messageController = TextEditingController();
  final focusNode = FocusNode();

  static bool chattedBefore = false;
  static String roomId = '';

  MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return BlocProvider(
      create: (context) => MessagingScreenCubit(),
      child: BlocConsumer<MessagingScreenCubit, MessagingScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = MessagingScreenCubit.getCubit(context);

            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: user.image == null
                            ? NetworkImage(
                                'https://surgassociates.com/wp-content/uploads/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.jpg')
                            : NetworkImage(user.image!),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user.name!.trim().split(' ').first,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
                body: Column(children: [
                  Expanded(
                      child: FutureBuilder(
                    future:
                        ChatStreamer.hasChattedBefore(chatUserId: user.uId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // they chatted before and there's a chats there
                        if (snapshot.data!.$1) {

                          chattedBefore = true;
                          roomId = snapshot.data!.$2!;
                          return Text(
                              'Chatted Before, get chats from room id :${snapshot.data!.$2} ');
                        }
                        // they didn't chatted before
                        else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Start Chatting with ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              GradientText(
                                user.name!,
                                gradient: GRADIENT_COLOR,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          );
                        }

                      } else if (snapshot.hasError) {
                        return Text('ERROR');
                      } else {
                        return Text('Loading Chats');
                      }
                    },
                  )),

                  Row(
                    children: [
                      if (messageController.text.isEmpty)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                color: Colors.green,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.green,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.mic,
                                color: Colors.pink,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        )
                      else
                        SizedBox(width: 20),
                      Expanded(
                        child: commentChattingTF(
                          controller: messageController,
                          focusNode: focusNode,
                          onChanged: (s) {
                            if (s!.isEmpty || s.length == 1) {
                              cubit.changeMessageText();
                              FocusScope.of(context).requestFocus(focusNode);
                            }
                          },
                          hintText: 'Write a message',
                          context: context,
                        ),
                      ),
                      if (messageController.text.isEmpty)
                        IconButton(
                          icon: Icon(
                            Icons.waving_hand_rounded,
                            color: Colors.orangeAccent,
                          ),
                          onPressed: () {},
                        )
                      else
                        Transform.rotate(
                          angle: -1.5707963268, // -90 degree in radian
                          child: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.pink,
                              ),
                              onPressed: () {
                              if(roomId.isEmpty){
                                cubit.getRoom(chatUserId: user.uId!);
                              }
                              if(messageController.text.isNotEmpty){
                                cubit.sendMessage(message: messageController.text, roomId: roomId);
                              }

                              }),
                        ),
                    ],
                  ),
                ]));
          }),
    );
  }
}
