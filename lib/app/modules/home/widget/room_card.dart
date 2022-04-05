import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/modules/room/room_screen.dart';
import 'package:vku_vote/app/widgets/button_rounder.dart';
import 'package:vku_vote/app/widgets/input_text.dart';

class RoomCard extends StatelessWidget {
  Election election;
  RoomCard({required this.election});

  final homeController = Get.find<HomeController>();

  void checkPasswordRoom() {
    if(election.keyRoom == homeController.editController1.text){
      homeController.getCandidateRoom(election.id);
      Get.back();
      Get.to(()=> RoomScreen(election: election),transition: Transition.rightToLeft);
    }else{
      Get.back();
      EasyLoading.showError("Sai mật khẩu");
    }
  }

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.widthP;
    return GestureDetector(
      onTap: () async {
        await Get.defaultDialog(
          title: "Mật khẩu phòng",
          contentPadding: EdgeInsets.symmetric(horizontal: 2.0.widthP),
          content: Form(
            key: homeController.formKey,
            child: Column(
              children: [
                InputText(
                  controller: homeController.editController1,
                  label: "Nhập mật khẩu phòng",
                  labelVaidate: "Vui lòng nhập mật khẩu",
                ),
                SizedBox(height: 2.5.widthP),
                ButtonRouder(label: "Xác nhận",onTap: (){
                  if(homeController.formKey.currentState!.validate()){
                    checkPasswordRoom();
                    homeController.renderTime(election);
                    homeController.editController1.clear();
                  }
                })
              ],
            )
          )
        );
      },
      child: Container(
        width: squareWidth,
        height: squareWidth/4,
        margin: EdgeInsets.all(2.0.widthP),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
             BoxShadow(
               color: Color.fromRGBO(0, 0, 0, 0.1),
               offset: Offset(0,0),
               blurRadius: 5,
               spreadRadius: 0.0
              )
          ],
          color: whiteColor
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0.widthP),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(election.name.toUpperCase(),style: TextStyle(
                    fontSize: 15.0.sizeP,
                    fontWeight: FontWeight.w700
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.0.heightP),
                  Text('10  Votes ',style: TextStyle(
                    fontSize: 12.0.sizeP,
                    color: primaryColor,
                    fontWeight: FontWeight.w600
                  ))
                ],
              ),
              Lottie.network('https://assets4.lottiefiles.com/packages/lf20_RJjNDZ.json',width: 10.0.widthP)
            ],
          ),
        ),
      ),
    );
  }
}