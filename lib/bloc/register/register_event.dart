// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}
class NoRegisterEvent extends RegisterEvent {}

class SendOtpEvent extends RegisterEvent {
  final String phoNo;

  const SendOtpEvent({required this.phoNo});
}

class AppStartEvent extends RegisterEvent {}

class VerifyOtpEvent extends RegisterEvent {
  final String otp;

  const VerifyOtpEvent({required this.otp});
}

class LogoutEvent extends RegisterEvent {}

class OtpSendEvent extends RegisterEvent {}

class LoginCompleteEvent extends RegisterEvent {
  final User firebaseUser;
  const LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends RegisterEvent {
  String message;

  LoginExceptionEvent(this.message);
}
