import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/modules/home/widget/room_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.widthP),
            child: Text("VOTE VKU",style: TextStyle(
              fontSize: 15.0.sizeP,
              fontWeight: FontWeight.w700
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.widthP),
            child: Text("Đang diễn ra",style: TextStyle(
              color: greyColor,
              fontSize: 13.0.sizeP,
              fontWeight: FontWeight.w500
            )),
          ),
          Padding(
            padding: EdgeInsets.all(2.0.widthP),
            child: Obx(
              ()=> ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.elections.map(((element) => RoomCard(election: element)))
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}