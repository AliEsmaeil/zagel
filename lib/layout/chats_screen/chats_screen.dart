import 'package:chat/components/separeted_comp/loading_chats.dart';
import 'package:chat/layout/chats_screen/cubit/states.dart';
import 'package:chat/models/user.dart';
import 'package:chat/layout/chats_screen/cubit/cubit.dart';
import 'package:chat/modules/messaging_screen/messaging_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatsScreenCubit(),
        child: BlocConsumer<ChatsScreenCubit, ChatsScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Flexible(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users').where('uId', isNotEqualTo: CurrentUser.user.uId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return ListView(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        children: [
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:snapshot.data!.docs.length ,
                                itemBuilder: (context, index) {
                                  var user = UserModel.fromJson(snapshot.data!.docs[index].data());
                                   return  Container(
                                     width: 80,
                                     height: 80,
                                     child: Column(
                                       children: [
                                         CircleAvatar(
                                           radius: 28,
                                           backgroundImage: user.image == null? NetworkImage('https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'):
                                           NetworkImage(user.image!),
                                         ),
                                         Text(
                                             user.name!.split(' ').first.trim(),
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                         ),
                                       ],
                                     ),
                                   );
                                }),
                          ),
                          SizedBox(height: 20,),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length ,
                              itemBuilder: (context, index) {
                                var user = UserModel.fromJson(snapshot.data!.docs[index].data());
                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(MessagingScreen.route, arguments: user);
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: user.image == null? NetworkImage('https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'):
                                      NetworkImage(user.image!),
                                    ),
                                    title: Text(user.name!),
                                    subtitle: Text(
                                        'Hi, How are you ali',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Text('Some Date'),
                                  ),
                                );
                              }),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('ERROR');
                    }
                    return const LoadingChats();
                  },
                ))

/*
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                    );
                  },
                ),
              ),

              Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context,index){
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('User Name'),
                      );
                    },
                  )
              ),
*/
              ],
            );
          },
        ));
  }
}
