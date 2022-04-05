import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';

class ButtonRouder extends StatelessWidget {
  String label;
  Function onTap;
  ButtonRouder({required this.label,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 5.0.widthP;
    return Container(
      width: squareWidth,
      height: 15.0.widthP,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)
        ),
        onPressed:()=> onTap(), 
        child: Text(label,style: TextStyle(
          fontSize: 13.0.sizeP,
          fontWeight: FontWeight.w600,
          color: whiteColor
        ))
      )
    );
  }
}