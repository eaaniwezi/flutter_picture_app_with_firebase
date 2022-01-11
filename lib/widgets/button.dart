import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool bottonHeight;
  const ButtonContainer({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.bottonHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 40,
        right: 40,
        top: bottonHeight == true ? MediaQuery.of(context).size.height * 0.2 : 0,
        bottom: 15,
      ),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff182647),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
