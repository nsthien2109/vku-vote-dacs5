import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'dart:math' as math;

class DetailCandidate extends StatelessWidget {
  Candidate candidate;
  DetailCandidate({required this.candidate});

  @override
  Widget build(BuildContext context) {
    Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    final squareWidth = Get.width - 5.0.sizeP;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: blackColor
        ),
        centerTitle: true,
        title: Text("Nguyễn Sĩ Thiện",style: TextStyle(
            color: blackColor,
            fontSize: 17.0.sizeP,
            fontWeight: FontWeight.w600
          ),
          overflow: TextOverflow.ellipsis,
        )
      ),
      body : SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: squareWidth,
            padding: EdgeInsets.all(4.0.widthP),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0.sizeP),
                  child: candidate.image !="" ? Image.network(candidate.image,fit: BoxFit.cover) : Container(
                    height: squareWidth,
                    margin: EdgeInsets.all(.1.widthP),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: blackColor,
                        width: .5
                      ),
                      borderRadius: BorderRadius.circular(10.0.sizeP)
                    ),
                    child: Center(
                      child: Text(candidate.name,style: TextStyle(
                        color: color,
                        fontSize: 25.0.sizeP,
                        fontWeight: FontWeight.w900
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 10.0.widthP),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(candidate.name,style: TextStyle(
                      fontSize: 18.0.sizeP,
                      fontWeight: FontWeight.w600
                    )),
                    Text("${candidate.numVotes} Vote",style: TextStyle(
                      fontSize: 15.0.sizeP,
                      color: Colors.green,
                      fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                SizedBox(height: 5.0.widthP),
                Text("Địa chỉ : ${candidate.address}",style: TextStyle(
                      fontSize: 15.0.sizeP,
                      fontWeight: FontWeight.w600
                  )
                ),
                SizedBox(height: 5.0.widthP),
                Text("Mô tả : ${candidate.description}",style: TextStyle(
                      fontSize: 12.0.sizeP,
                      fontWeight: FontWeight.w400,
                      color: greyColor
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}