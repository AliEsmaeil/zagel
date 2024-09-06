import 'package:chat/core/constants/routes.dart';
import 'package:chat/core/themes/themes.dart';
import 'package:chat/modules/home/cubit/cubit.dart';
import 'package:chat/utils/bloc_observer.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/firebase_options.dart';
import 'package:chat/utils/start_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/home/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CurrentUser.initiateUser();
  Bloc.observer = MyBlocObserver();
  await Future.delayed(const Duration(milliseconds: 200));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: MaterialApp(
        initialRoute: StartHandler.startScreen(),
        routes: routes,
        debugShowCheckedModeBanner: false,
        title: 'Zagel',
        theme: CustomTheme.lightTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
