// ignore_for_file: prefer_function_declarations_over_variables, avoid_print, avoid_renaming_method_parameters, non_constant_identifier_names, unnecessary_this

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_picture_app/repository/user_repository.dart';
import 'package:logger/logger.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  StreamSubscription? subscription;
  var log = Logger();
  String verID = "";
  RegisterBloc({
    required InitialRegisterState authInitState,
    required this.userRepository,
  }) : super(authInitState) {
    add(NoRegisterEvent());
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();

      subscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });

      yield PhoneNumberSentState();
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield RegisterCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        UserCredential result =
            await userRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield RegisterCompleteState(result.user!);
          userRepository.createUserCollectionInFireStore({
            'uid': result.user!.uid,
            'phoneNumber': result.user!.phoneNumber,
          });
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
      }
    }
  }

  Stream<RegisterEvent> sendOtp(String phoNo) async* {
    StreamController<RegisterEvent> eventStream = StreamController();
    final PhoneVerificationCompleted = (AuthCredential authCredential) {
      userRepository.getUser();
      userRepository.getUser().catchError((onError) {}).then((user) {
        eventStream.add(LoginCompleteEvent(user!));
        eventStream.close();
      });
    };
    final PhoneVerificationFailed = (dynamic authException) {
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final PhoneCodeSent = (String verId, [int? forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final PhoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await userRepository.sendOtp(
        phoNo,
        const Duration(seconds: 1),
        PhoneVerificationFailed,
        PhoneVerificationCompleted,
        PhoneCodeSent,
        PhoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }

  @override
  void onChange(Change<RegisterState> change) {
    log.w(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(RegisterEvent event) {
    log.w(event);
    super.onEvent(event);
  }
}
