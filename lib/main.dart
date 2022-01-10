// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_picture_app/bloc/auth/auth_bloc.dart';
import 'package:firebase_picture_app/bloc/picture/picture_bloc.dart';
import 'package:firebase_picture_app/bloc/register/register_bloc.dart';
import 'package:firebase_picture_app/repository/picture_repository.dart';
import 'package:firebase_picture_app/repository/user_repository.dart';
import 'package:firebase_picture_app/screens/home_screen.dart';
import 'package:firebase_picture_app/screens/login_screen.dart';
import 'package:firebase_picture_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userRepository = UserRepository();
  final pictureRepository = PictureRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authInitState: InitialAuthenticationState(),
            userRepository: userRepository,
          )..add(
              NoEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(
            authInitState: InitialRegisterState(),
            userRepository: userRepository,
          )..add(
              NoRegisterEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => PictureBloc(
            pictureInitState: PictureInitialState(),
            pictureRepository: pictureRepository,
          )..add(
              NoPictureEvent(),
            ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print(state.toString() + " this is your state");
          if (state is Uninitialized) {
            return SlapshScreen();
          } else if (state is Unauthenticated) {
            return LoginScreen();
          } else if (state is Authenticated) {
            return HomeScreen();
          } else {
            return SlapshScreen();
          }
        },
      ),
    );
  }
}
