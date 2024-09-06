import 'package:bloc/bloc.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/signup/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class SignUpCubit extends Cubit<SignUpStates>{

  bool visible = false;

  SignUpCubit():super(SignUpInitialState());

  static SignUpCubit getCubit(context)=>BlocProvider.of(context);

  void changePasswordVisibility(){
    visible = !visible;
    emit(SignUpPasswordVisibilityState());
  }

  void createUser({required UserModel user})async{

    try{

      emit(SignUpLoadingState());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password )
          .then((value) async{
            user.uId = value.user?.uid;
            await FirebaseFirestore.instance.collection('users').doc(user.uId).set(user.toJson()).then((value) {
              emit(SignUpCreatedUserState());
            });
      });

    }
    on FirebaseAuthException catch(e){
      emit(SignUpCreatedUserErrorState(e.code));
    }
    on FirebaseException catch(e){
      emit(SignUpCreatedUserErrorState(e.message!));
    }
    catch(e){
      emit(SignUpCreatedUserErrorState(e.toString()));
    }
  }
}