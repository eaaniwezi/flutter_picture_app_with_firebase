// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

//*
class InitialRegisterState extends RegisterState {
  @override
  List<Object> get props => [];
}
//*
class PhoneNumberSentState extends RegisterState {
  @override
  List<Object> get props => [];
}

//*
class OtpSentState extends RegisterState {
  @override
  List<Object> get props => [];
}

//*
class LoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

//*
class OtpVerifiedState extends RegisterState {
  @override
  List<Object> get props => [];
}

//*
class RegisterCompleteState extends RegisterState {
  final User _firebaseUser;

  const RegisterCompleteState(this._firebaseUser);

  User getUser() {
    return _firebaseUser;
  }

  @override
  List<Object> get props => [_firebaseUser];
}

//*
class ExceptionState extends RegisterState {
  String message;

  ExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

//*
class OtpExceptionState extends RegisterState {
  String message;

  OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
