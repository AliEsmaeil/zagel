import 'package:chat/components/separeted_comp/post_zoomer.dart';
import 'package:chat/modules/comments_screen/comments_Screen.dart';
import 'package:chat/modules/create_post/create_post_screen.dart';
import 'package:chat/modules/home/home_screen.dart';
import 'package:chat/modules/likes_screen/likes_screen.dart';
import 'package:chat/modules/messaging_screen/messaging_screen.dart';
import 'package:chat/modules/profile/edit/edit_screen.dart';
import 'package:chat/modules/profile/profile_screen.dart';
import 'package:chat/modules/signin/signin_screen.dart';
import 'package:chat/modules/signup/signup_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> routes = {

  SignInScreen.route : (context)=> SignInScreen(),
  SignUpScreen.route : (context)=>SignUpScreen(),
  HomeScreen.route : (context)=>HomeScreen(),
  ProfileScreen.route : (context)=>ProfileScreen(),
  EditProfileScreen.route : (context)=>EditProfileScreen(),
  CreatePostScreen.route : (context)=>CreatePostScreen(),
  PostZoomer.route : (context)=>PostZoomer(),
  CommentsScreen.route : (context)=>CommentsScreen(),
  LikesScreen.route : (context)=>LikesScreen(),
  MessagingScreen.route : (context)=>MessagingScreen(),
};