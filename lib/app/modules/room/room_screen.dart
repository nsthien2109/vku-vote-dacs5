import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/modules/room/widget/add_card.dart';
import 'package:vku_vote/app/modules/room/widget/candidate_card.dart';
import 'package:vku_vote/app/modules/room/widget/chart.dart';
import 'package:vku_vote/app/modules/room/widget/result_card.dart';
import 'package:vku_vote/app/modules/room/widget/vote_candidate_card.dart';

class RoomScreen extends StatelessWidget {
  Election election;
  RoomScreen({required this.election});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {    
    final squareWidth = Get.width - 5.0.sizeP;
    return Scaffold(
      body: Obx(
        ()=> homeController.isLoading.value ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 1.0.widthP,
              ),
              SizedBox(height: 5.0.widthP),
              Text("Đang xử lý",style: TextStyle(
                fontSize: 9.0.sizeP,
                fontWeight: FontWeight.w600
              ))
            ],
          ),
        ) : homeController.isEnding.value ? const ResultCard() :  ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.widthP),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: ()=>Get.back(), 
                    icon: Icon(Icons.chevron_left_outlined,size: 30.0.sizeP),
                    splashRadius: 1.0.sizeP
                  ),
                  Text(election.name,style: TextStyle(
                      color: blackColor,
                      fontSize: 17.0.sizeP,
                      fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      IconButton(
                        splashRadius: 1.0.sizeP,
                        onPressed: ()=>Get.to(()=> ElectionChart(candidates: homeController.candidatesRoom),transition: Transition.zoom), 
                        icon: Icon(Icons.donut_large_outlined,size: 20.0.sizeP)
                      ),
                      election.authRoom == homeController.publicKeyVoter.value.toLowerCase() ? IconButton(
                        splashRadius: 1.0.sizeP,
                        onPressed: ()=>Get.to(()=> ElectionChart(candidates: homeController.candidatesRoom),transition: Transition.zoom), 
                        icon: Icon(Icons.remove_circle_outline_outlined,size: 20.0.sizeP,color: Colors.red)
                      ) : Container()
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.widthP),
              child: Text("Kết thúc sau",style: TextStyle(
                color: greyColor,
                fontSize: 15.0.sizeP,
                fontWeight: FontWeight.w500
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.widthP),
              child: Obx(
                ()=>  Center(
                  child: TimerCountdown(
                    timeTextStyle: TextStyle(
                      fontSize: 15.0.sizeP,
                      color: homeController.colorCountDown.value,
                      fontWeight: FontWeight.w600
                    ),
                    format: CountDownTimerFormat.daysHoursMinutesSeconds,
                    daysDescription: "Ngày",
                    hoursDescription: "Giờ",
                    minutesDescription: "Phút",
                    secondsDescription: "Giây",
                    endTime: DateTime.now().add(
                      Duration(
                        days: homeController.day.value,
                        hours: homeController.hour.value,
                        minutes: homeController.minutes.value,
                        seconds:homeController.second.value,
                      ),
                    ),
                    onEnd: () => homeController.renderTime(election),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.widthP),
              child: Text("Ứng cử viên",style: TextStyle(
                color: greyColor,
                fontSize: 15.0.sizeP,
                fontWeight: FontWeight.w500
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.0.widthP),
              child: Container(
                padding: EdgeInsets.all(2.0.widthP),
                width: squareWidth,
                height: squareWidth / 1.8,
                child: Obx(
                  () => ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children:  [
                      ...homeController.candidatesRoom.map((element)=> CandidateCard(candidate: element)),
                      AddCard(election: election)
                    ],
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(4.0.widthP),
              child: Text("Bỏ phiếu",style: TextStyle(
                color: greyColor,
                fontSize: 15.0.sizeP,
                fontWeight: FontWeight.w500
              )),
            ),
            SizedBox(
              width: squareWidth,
              height: Get.height - squareWidth,
              child: Obx(
                ()=> ListView(
                  children: [
                   ...homeController.candidatesRoom.map((element)=> VoteCandidateCard(candidate: element, roomID: election.id))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () async {
          await Get.defaultDialog(            
            title: "Chi tiết phòng",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tên phòng : ${election.name}",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w500
                )),
                SizedBox(height: 3.0.widthP),
                Text("Mô tả : ${election.description}",style: TextStyle(
                  fontSize: 13.0.sizeP,
                  fontWeight: FontWeight.w400
                )),
                SizedBox(height: 3.0.widthP),
                Text("Mật khẩu phòng : ${election.keyRoom}",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w500
                )),
                SizedBox(height: 3.0.widthP),
                Text("Bắt đầu lúc : ${election.startTime}",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
                )),
                SizedBox(height: 3.0.widthP),
                Text("Kết thúc lúc : ${election.endTime}",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w500,
                  color: Colors.red
                )),
                SizedBox(height: 3.0.widthP),
                Text("Người / Nội dung chiến thắng : Chưa",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber
                )),
              ],
            )
          );
        },
        child: const Icon(Icons.article_outlined),
      ),
    );
  }
}