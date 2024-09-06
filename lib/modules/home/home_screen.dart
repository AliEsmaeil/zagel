
import 'dart:developer';

import 'package:chat/layout/chats_screen/chats_screen.dart';
import 'package:chat/layout/posts/posts_screen.dart';
import 'package:chat/modules/profile/profile_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'HOME';


  //final postRefreshKey = GlobalKey<RefreshIndicatorState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) => [
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                floating: true,
                leadingWidth: 75,
                leading: GestureDetector(
                  onTap: () {
                    log('YOU PRESSED THE IMAGE');
                    Navigator.of(context).pushNamed(ProfileScreen.route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: CurrentUser.user.image == null
                          ? NetworkImage(
                              'https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg')
                          : NetworkImage(CurrentUser.user.image!),
                    ),
                  ),
                ),
                title: Text('Zagel'),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                    ),
                    onPressed: () {},
                  ),
                ],

                elevation: 0,
                scrolledUnderElevation: 0,
              ),
            ],
            body: Column(
              children: [

                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: 'Posts',
                      ),
                      Tab(
                        text: 'Chats',
                      ),
                      Tab(
                        text: 'Users',
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: TabBarView(
                    children: [
                      PostScreen(key: UniqueKey(),),
                      ChatsScreen(key: UniqueKey()),

                      ListView.builder(
                        key: UniqueKey(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.black,
                            height: 120,
                          ),
                        ),
                        itemCount: 60,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}