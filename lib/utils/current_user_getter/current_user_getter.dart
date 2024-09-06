import 'package:chat/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final class CurrentUser {
  static late UserModel user;
  //static bool shouldReInitiate = true;

  static Future<void> initiateUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data() as Map<String, dynamic>);
    }).catchError((error) {
      debugPrint('error getting current user: $error');
    });
  }
}
