import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/widgets/button_rounder.dart';
import 'package:vku_vote/app/widgets/input_text.dart';

class AddCandidate extends StatelessWidget {
  Election election;
  AddCandidate({required this.election}) ;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 5.0.sizeP;
    const String assetName = 'assets/images/img/candidateImage.svg';
    final Widget candidateImage = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Fox',
      width: 200.0.sizeP,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: blackColor
        ),
        centerTitle: true,
        title: Text("Thêm ứng viên",style: TextStyle(
            color: blackColor,
            fontSize: 17.0.sizeP,
            fontWeight: FontWeight.w600
          ),
          overflow: TextOverflow.ellipsis,
        )
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(4.0.widthP),
          width: squareWidth,
          child: Form(
            key: homeController.formKey1,
            child: Column(
              children: [
                candidateImage,
                SizedBox(height: 15.0.widthP),
                InputText(
                  label: "Tên ứng viên hoặc tên nội dung biểu quyết",
                  controller: homeController.editController1,
                  labelVaidate: "Vui lòng nhập tên ứng viên",
                ),
                SizedBox(height: 5.0.widthP),
                InputText(
                  label: "Địa chỉ / Địa Điểm",
                  controller: homeController.editController2,
                  labelVaidate : "Vui lòng nhập địa chỉ hoặc địa điểm"
                ),
                SizedBox(height: 5.0.widthP),
                InputText(
                  label: "Mô tả chi tiết",
                  controller: homeController.editController3,
                  labelVaidate: "Vui lòng nhập mô tả",
                ),
                SizedBox(height: 5.0.widthP),
                InputText(
                  label: "Liên kết hình ảnh đại diện (URL)",
                  controller: homeController.editController4,                
                ),
                SizedBox(height: 5.0.widthP),
                ButtonRouder(label: "Xác nhận", onTap: (){
                  if(homeController.formKey1.currentState!.validate()){
                    var success = homeController.addCandidate(
                      Candidate(
                        id: homeController.candidateCount.value, 
                        name: homeController.editController1.text, 
                        address: homeController.editController2.text, 
                        description: homeController.editController3.text, 
                        image: homeController.editController4.text, 
                        numVotes: 0
                      ), 
                      election.id
                    );
                    Get.back();
                    success ? EasyLoading.showSuccess("Thêm thành công") : EasyLoading.showError("Thêm thất bại");
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}