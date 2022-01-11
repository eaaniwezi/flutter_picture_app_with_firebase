// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:firebase_picture_app/bloc/auth/auth_bloc.dart';
import 'package:firebase_picture_app/screens/home_screen.dart';
import 'package:firebase_picture_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (oldState, newState) => newState is Unauthenticated,
      listener: (context, state) {
        Get.to(() => LoginScreen());
      },
      child: blocAppBarBuilder(),
    );
  }

  blocAppBarBuilder() {
    var log = Logger();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          dynamic userModel = state.user;
          log.v(userModel);
          return Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("Привет"),
                  accountEmail: Text(userModel.phoneNumber.toString()),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                    },
                    child: ListTile(
                        title: Text("выход"),
                        leading: Icon(Icons.exit_to_app_rounded,
                            color: Colors.red))),
              ],
            ),
          );
        }
        return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Привет"),
                accountEmail: Text("подождите немного"),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
