// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_picture_app/models/user_model.dart';
import 'package:firebase_picture_app/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({
    required InitialAuthenticationState authInitState,
    required this.userRepository,
  }) : super(authInitState) {
    add(NoEvent());
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is NoEvent) {
      final bool hasToken = await userRepository.getUser() != null;
      print(hasToken.toString() + " this is the token");
      if (hasToken) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedInEvent) {
      yield Loading();
      yield Authenticated();
    }

    if (event is LogOutEvent) {
      yield Loading();
      yield Unauthenticated();
    }
  }
}
