// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_picture_app/models/user_model.dart';
import 'package:firebase_picture_app/repository/user_repository.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  var log = Logger();

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
      try {
        late User? _user;
        _user = await userRepository.getUser();

        if (hasToken) {
          yield Authenticated(user: _user!);
        } else {
          yield Unauthenticated();
        }
      } catch (e) {
        log.wtf(e);
      }
    }

    if (event is LoggedInEvent) {
      late User? _userModel;
      _userModel = await userRepository.getUser();

      yield Loading();
      yield Authenticated(user: _userModel!);
    }

    if (event is LogOutEvent) {
      // yield Loading();
      userRepository.signOut();
      yield Unauthenticated();
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    log.i(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(AuthEvent event) {
    log.i(event);
    super.onEvent(event);
  }
}
