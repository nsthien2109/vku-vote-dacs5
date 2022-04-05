import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/modules/profile/widget/profile_card.dart';
import 'package:vku_vote/app/modules/profile/widget/wallet_card.dart';
import 'package:vku_vote/app/modules/room/widget/add_room.dart';

class ProfileScreen extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: Container(
          width: Get.width,
          padding: EdgeInsets.all(4.0.widthP),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileCard(),
              const WalletCard(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0.widthP),
                width: Get.width - 40.0.sizeP,
                height: 20.0.widthP,
                padding: EdgeInsets.all(2.0.widthP),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: lightGreyColor
                  )
                ),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  onPressed: ()=> Get.to(()=> const RoomAdd(),transition: Transition.zoom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tạo phòng bầu cử mới",style: TextStyle(
                        fontSize: 15.0.sizeP,
                        color: blackColor
                      )),
                      const Icon(Icons.meeting_room_outlined,color: blackColor)
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
                onPressed: (){
                  homeController.logout();
                }, 
                child: const Text("Đăng xuất")
              )
            ],
          ),
        ),
      )
    );
  }
}