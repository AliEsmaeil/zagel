
import 'dart:io';

import 'package:chat/modules/profile/edit/cubit/states.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/image_picker.dart';
import 'package:chat/utils/streamers/image_uploader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreenCubit extends Cubit<EditProfileScreenStates>{

  File? cover;
  File? image;

  EditProfileScreenCubit():super(EditProfileScreenInitialState());

  static EditProfileScreenCubit getCubit(BuildContext context)=>BlocProvider.of(context);

  void getUserImage(ImageSource source)async{

    image = await MyImagePicker.pickImage(source) ;
    if(image != null) {
      emit(EditProfileScreenGotImageState());
    }
  }

  void getUserCover(ImageSource source)async{
    cover = await MyImagePicker.pickImage(source) ;
    if(cover != null) {
      emit(EditProfileScreenGotImageState());
    }
  }

  void updateUser({required String name, required String phone, required String bio})async{
    emit(UserUpdateLoadingState());
    var rec = await uploadImages();
    var map = {
      'name' : name,
      'bio' : bio,
      'phone' : phone,
    };
    if(rec.imageLink.isNotEmpty){
      map['image'] = rec.imageLink;
    }
    if(rec.coverLink.isNotEmpty){
      map['cover'] = rec.coverLink;
    }
    try{
      await FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(map).then((value){
            CurrentUser.initiateUser(); // get user again
            emit(SuccessfulUserUpdateState());
      });
    }catch(e){
      debugPrint('Exception in user update $e');
      emit(UserUpdateErrorState());
    }

  }
 Future<({String imageLink, String coverLink})> uploadImages()async{

    String img = '';
    String cov = '';

    try{

      if(image != null){
        img = await ImageUploader(image: image!).uploadImage(storagePath: 'userImages/${CurrentUser.user.uId}');
      }
      if(cover != null){
        cov = await ImageUploader(image: cover!).uploadImage(storagePath: 'userImages/${CurrentUser.user.uId}');
      }

    }
      catch(e){
        emit(ImageUploadErrorState());
      }

    return (imageLink: img, coverLink : cov);
  }

}