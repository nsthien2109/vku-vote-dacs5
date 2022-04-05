import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';

class ProfileCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  ProfileCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.widthP;
    const String assetName = 'assets/images/img/avatar.svg';
    final Widget avatarImage = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Avatar',
      width: 100.0.sizeP,
    );

    return Container(
      width: squareWidth,
      height: squareWidth/2.3,
      padding: EdgeInsets.symmetric(horizontal: 3.0.widthP),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
           BoxShadow(
             color: Color.fromRGBO(67, 71, 85, 0.27),
             offset: Offset(3,2),
             blurRadius: 3,
             spreadRadius: 0.0
            )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: whiteColor,
            radius: 40.0.sizeP,
            child: avatarImage,
          ),
          SizedBox(width: 2.0.widthP),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  ()=> Text(homeController.nameVoter.value,style: TextStyle(
                    fontSize: 15.0.sizeP,
                    fontWeight: FontWeight.w700
                  )),
                ),
                SizedBox(height: 1.5.widthP),
                Obx(
                  ()=> Text(homeController.publicKeyVoter.value,style: TextStyle(
                      fontSize: 13.0.sizeP
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}