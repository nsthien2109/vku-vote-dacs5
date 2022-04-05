import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: blackColor
        ),
        centerTitle: true,
        title: Text("Bầu cử sắc đẹp",style: TextStyle(
            color: blackColor,
            fontSize: 17.0.sizeP,
            fontWeight: FontWeight.w600
          ),
          overflow: TextOverflow.ellipsis,
        )
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: whiteColor,
          width: Get.width,
          padding: EdgeInsets.all(4.0.widthP),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network('https://assets2.lottiefiles.com/packages/lf20_HLo5AP.json'),
              SizedBox(height: 5.0.widthP),
              Text("Kết quả".toUpperCase(),style: TextStyle(
                fontSize: 20.0.sizeP,
                fontWeight: FontWeight.w700,
                color: Colors.amber
              )),
              SizedBox(height: 5.0.widthP),
              Text("Cuộc bầu cử đã kết thúc với kết quả",style: TextStyle(
                  fontSize: 18.0.sizeP,
                  fontWeight: FontWeight.w700
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0.widthP),
              Text("Nguyễn Sĩ Thiện 17/30 phiếu",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
              Lottie.network('https://assets1.lottiefiles.com/packages/lf20_byBsNp.json')
            ],
          ),
        ),
      ),
    );
  }
}