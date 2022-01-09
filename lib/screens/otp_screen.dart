// ignore_for_file: prefer_const_constructors

import 'package:firebase_picture_app/bloc/auth/auth_bloc.dart';
import 'package:firebase_picture_app/bloc/register/register_bloc.dart';
import 'package:firebase_picture_app/screens/home_screen.dart';
import 'package:firebase_picture_app/screens/login_screen.dart';
import 'package:firebase_picture_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKeys = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  String enteredCode = "";
  bool isCodeTrue = false;
  var log = Logger();
  @override
  void initState() {
    super.initState();

    _listenOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.to(() => LoginScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black38,
          ),
        ),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          log.d(state);
          if (state is OtpExceptionState || state is ExceptionState) {
            setState(() {
              isCodeTrue = true;
            });
          } else if (state is RegisterCompleteState) {
            print(state.getUser().uid.toString() + " this os the user id");
            BlocProvider.of<AuthBloc>(context)
                .add(LoggedInEvent(token: state.getUser().uid));
            Get.to(() => HomeScreen());
          }
        },
        child: Form(
          key: _formKeys,
          child: ListView(
            children: [
              _header(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    colorBuilder: isCodeTrue == false
                        ? FixedColorBuilder(Colors.black)
                        : FixedColorBuilder(Colors.red),
                  ),
                  controller: codeController,
                  codeLength: 6,
                ),
              ),
              _wrongCodeInfo(),
              ButtonContainer(
                label: "отправить код",
                onPressed: () async {
                  if (codeController.text.length == 6) {
                    var enteredCode = codeController.text;
                    context
                        .read<RegisterBloc>()
                        .add(VerifyOtpEvent(otp: enteredCode));
                  } else if (codeController.text.length != 6) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _wrongCodeInfo() {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is OtpExceptionState || state is ExceptionState) {}
      },
      builder: (context, state) {
        if (state is OtpExceptionState || state is ExceptionState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
              top: 10,
              bottom: 15,
            ),
            child: Text(
              "Неправильный код.\nПовторите пожалуйста еще раз.",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
        return Text("");
      },
    );
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  _header() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        "Код из сообщения",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),
      ),
    );
  }
}
