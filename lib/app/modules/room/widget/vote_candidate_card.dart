import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';

class VoteCandidateCard extends StatelessWidget {
  Candidate candidate;
  int roomID;
  final homeController = Get.find<HomeController>();
  VoteCandidateCard({required this.candidate, required this.roomID});

  @override
  Widget build(BuildContext context) {
    return ListTile(
              style: ListTileStyle.drawer,
              trailing: Container(
                width: 20.0.widthP,
                height: 10.0.widthP,
                decoration : BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(20.0.sizeP)
                ),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  onPressed: (){
                    try {
                      homeController.voteAction(candidate.id, roomID);
                      EasyLoading.showSuccess("Đã bỏ phiếu");
                    } catch (e) {
                      EasyLoading.showError("Bạn đã bỏ phiếu");
                    }
                  }, 
                  child: Text("Vote",style: TextStyle(
                    color: whiteColor,
                    fontSize: 13.0.sizeP
                ))),
              ),
              title: Text(candidate.name,style: TextStyle(
                fontSize: 16.0.sizeP,
                fontWeight: FontWeight.w500
              )),
              subtitle: Text("${candidate.numVotes} Votes",style: TextStyle(
                fontSize: 12.0.sizeP,
                fontWeight: FontWeight.w500
          )),
        );
  }
}