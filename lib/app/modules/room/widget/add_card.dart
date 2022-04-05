import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/modules/room/widget/add_candidate.dart';

class AddCard extends StatelessWidget {
  Election election;
  AddCard({required this.election});

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 5.0.sizeP;
    return GestureDetector(
      onTap: ()=> Get.to(()=> AddCandidate(election: election),transition: Transition.circularReveal),
      child: Container(
        width: squareWidth/3,
        margin: EdgeInsets.only(right: 2.0.widthP,top: 2.0.widthP,bottom: 2.0.widthP),
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(5.0.sizeP),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(17, 17, 26, 0.1),
              offset: Offset(0, 4),
              blurRadius: 15
            ),
          ]
        ),
        child: DottedBorder(
          color: greyColor,
          radius: Radius.circular(5.0.widthP),
          dashPattern: const [5,4],
          child: const Center(
            child: Icon(Icons.add),
          )
        ),
      ),
    );
  }
}