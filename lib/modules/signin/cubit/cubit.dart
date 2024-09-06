import 'package:bloc/bloc.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/signin/cubit/states.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class SignInCubit extends Cubit<SignInStates>{

  bool visible = false;

  SignInCubit():super(SignInInitialState());

  static SignInCubit getCubit(context)=>BlocProvider.of(context);

  void changePasswordVisibility(){
    visible = !visible;
    emit(SignInPasswordVisibilityState());
  }

  void signIn({required UserModel user})async{
    emit(SignInLoadingState());

    try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password).then((value) async{
            await CurrentUser.initiateUser().then((value) {
              emit(SignInSuccessLoginState());
            });
     });
    }
    on FirebaseAuthException catch(e){
      emit(SignInLoginErrorState(e.code));
    }
    on FirebaseException catch(e){
      emit(SignInLoginErrorState(e.message!));
    }
    catch(e){
      emit(SignInLoginErrorState(e.toString()));
    }
  }
}