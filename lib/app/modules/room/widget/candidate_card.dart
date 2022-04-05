import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'package:vku_vote/app/modules/room/widget/detail_candidate.dart';

class CandidateCard extends StatelessWidget {
  Candidate candidate;
  CandidateCard({ required this.candidate}) ;

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 5.0.sizeP;
    Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return GestureDetector(
      onTap: ()=> Get.to(()=> DetailCandidate(candidate: candidate),transition: Transition.leftToRight),
      child: Container(
        width: squareWidth/3,
        margin: EdgeInsets.only(right: 2.0.widthP,top: 2.0.widthP,bottom: 2.0.widthP),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5.0.sizeP),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(17, 17, 26, 0.1),
              offset: Offset(0, 4),
              blurRadius: 15
            ),
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: squareWidth/3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 0.3.sizeP
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0.sizeP),topRight: Radius.circular(5.0.sizeP)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0.sizeP),topRight: Radius.circular(5.0.sizeP)),
                child: candidate.image != "" ? Image.network(candidate.image,fit: BoxFit.cover) : Center(child: Text(candidate.name,style: TextStyle(
                    fontSize: 10.0.sizeP,
                    fontWeight: FontWeight.w900,
                    color: color
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0.widthP),
              child: Text(candidate.name,style: TextStyle(
                  fontSize: 10.0.sizeP,
                  fontWeight: FontWeight.w800
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.widthP),
              child: Text("${candidate.numVotes} Votes",style: TextStyle(
                  fontSize: 10.0.sizeP,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}