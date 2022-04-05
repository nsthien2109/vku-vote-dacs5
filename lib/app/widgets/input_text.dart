import 'package:flutter/material.dart';
import 'package:vku_vote/app/core/values/colors.dart';

class InputText extends StatelessWidget {
  String label;
  String? labelVaidate;
  TextEditingController? controller;
  InputText({ required this.label, this.labelVaidate,this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator : (val) => val == null ?  labelVaidate : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: lightGreyColor
          )
        )
      ),
    );
  }
}