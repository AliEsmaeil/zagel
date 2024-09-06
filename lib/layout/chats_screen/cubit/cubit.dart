import 'package:chat/layout/chats_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ChatsScreenCubit extends Cubit<ChatsScreenStates>{

  ChatsScreenCubit ():super(ChatsScreenInitialState());

  static ChatsScreenCubit getCubit(context)=>BlocProvider.of(context);

}