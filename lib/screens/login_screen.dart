// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_picture_app/bloc/register/register_bloc.dart';
import 'package:firebase_picture_app/screens/otp_screen.dart';
import 'package:firebase_picture_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  dynamic isFieldValid = false;
  dynamic fullPhoneNumber = "";
  bool isLoading = false;
  String initialCountry = 'RU';
  PhoneNumber number = PhoneNumber(isoCode: 'RU');
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: BlocListener<RegisterBloc, RegisterState>(
          // listenWhen: (oldState, newState) => newState is OtpSentState,
          listener: (context, state) {
            print(state.toString() + " my state");
            if (state is LoadingState) {
              setState(() {
                isLoading = true;
              });
              // Get.to(() => SlapshScreen(
              //       description: "Отправка запроса....",
              //     ));
            } else if (state is ExceptionState || state is OtpExceptionState) {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(msg: "Ошибка!! Попробуйте еще раз позже");
            } else if (state is OtpSentState) {
              Get.to(() => OtpScreen());
            }
          },
          child: ListView(
            children: [
              _header(),
              _infoText(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Theme(
                  data: ThemeData(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Color(0xff182647),
                        ),
                  ),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        fullPhoneNumber = number.phoneNumber;
                      });
                    },
                    onInputValidated: (bool value) {
                      setState(() {
                        isFieldValid = value;
                      });
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: phoneNumberController,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {},
                  ),
                ),
              ),
              ButtonContainer(
                bottonHeight: true,
                label:
                    isLoading == true ? "Отправка запроса...." : "Продолжить",
                onPressed: isLoading == true
                    ? () {
                        Fluttertoast.showToast(
                            msg: "пожалуйста, подождите,\nотправляя запрос");
                      }
                    : () async {
                        if (isFieldValid == true) {
                          var completeNumber = fullPhoneNumber.toString();

                          final signCode = await SmsAutoFill().getAppSignature;

                          BlocProvider.of<RegisterBloc>(context).add(
                            SendOtpEvent(phoNo: completeNumber),
                          );
                          print("testss");
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        "Мой номер телефона",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  _infoText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        "Вам придет сообщение с кодом.\nНикому его не говорите.",
        style: TextStyle(
          color: Colors.black45,
        ),
      ),
    );
  }
}
