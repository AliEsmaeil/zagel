import 'package:chat/modules/create_post/create_post_screen.dart';
import 'package:chat/modules/profile/edit/edit_screen.dart';
import 'package:chat/modules/profile/profile_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modules/home/home_screen.dart';
import '../modules/signin/signin_screen.dart';

final class StartHandler{

  static String startScreen(){

    if(FirebaseAuth.instance.currentUser != null) { // old user

      return HomeScreen.route;
    }
    return SignInScreen.route;
    //return SignInScreen.route; //new user
  }

  static void initiateUser()async{
    await CurrentUser.initiateUser();
  }

}