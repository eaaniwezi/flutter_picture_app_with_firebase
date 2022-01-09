part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class NoEvent extends AuthEvent {}

class LoggedInEvent extends AuthEvent {
  final String token;

  const LoggedInEvent({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class LogOutEvent extends AuthEvent {}
