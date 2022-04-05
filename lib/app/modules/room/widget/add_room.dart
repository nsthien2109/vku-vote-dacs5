import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/widgets/button_rounder.dart';
import 'package:vku_vote/app/widgets/input_text.dart';

class RoomAdd extends StatefulWidget {
  const RoomAdd({ Key? key }) : super(key: key);

  @override
  State<RoomAdd> createState() => _RoomAddState();
}

class _RoomAddState extends State<RoomAdd> {
   final homeController = Get.find<HomeController>();
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");


  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width;
    const String assetName = 'assets/images/img/create-room.svg';
    final Widget createImage = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Fox',
      width: 150.0.sizeP,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: blackColor
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(5.0.widthP),
            width: squareWidth,
            child: Form(
              key: homeController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createImage,
                  SizedBox(height: 10.0.widthP),
                  InputText(
                    labelVaidate: "Vui lòng nhập tên phòng",
                    controller: homeController.editController1,
                    label: "Tên phòng"
                  ),
                  SizedBox(height: 5.0.widthP),
                  InputText(
                    labelVaidate: "Vui lòng nhập mô tả phòng",
                    controller: homeController.editController2,
                    label: "Mô tả"
                  ),
                  SizedBox(height: 5.0.widthP),
                  InputText(
                    labelVaidate: "Vui lòng nhập mật khẩu phòng",
                    controller: homeController.editController3,
                    label: "Mật khẩu phòng"
                  ),
                  SizedBox(height: 5.0.widthP),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: blueColor
                          ),
                          onPressed: ()=>_startTimePicker(context), child: Text("Bắt đầu",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0.sizeP
                          ))),
                        SizedBox(height: 3.0.widthP),
                        Text(dateFormat.format(startTime),style: TextStyle(
                          fontSize: 12.0.sizeP,
                          fontWeight: FontWeight.w500
                        )),
                      ],
                     ),
                      Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent
                          ),
                          onPressed: ()=>_endTimePicker(context), child: Text("Kết thúc",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0.sizeP
                          ))),
                        SizedBox(height: 3.0.widthP),
                        Text(dateFormat.format(endTime),style: TextStyle(
                          fontSize: 12.0.sizeP,
                          fontWeight: FontWeight.w500
                        )),
                      ],
                     ),
                    ],
                  ),
                  SizedBox(height: 5.0.widthP),
                  ButtonRouder(label: "Tạo phòng",onTap: () async {
                    if (homeController.formKey.currentState!.validate()) {
                      final String authRoom = homeController.publicKeyVoter.value;
                      var success = homeController.addElection(Election(
                        id: homeController.elections.length, 
                        name: homeController.editController1.text, 
                        description: homeController.editController2.text, 
                        keyRoom: homeController.editController3.text, 
                        authRoom: authRoom, 
                        startTime: startTime, 
                        endTime: endTime
                        )
                      );
                      Get.back();
                      success ? EasyLoading.showSuccess('Tạo phòng thành công !') : EasyLoading.showError('Lỗi, Vui lòng thử lại');
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

    _startTimePicker(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (builder)=>
      DateTimePicker(
        type: DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        initialValue: startTime.toString(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
        icon: const Icon(Icons.event),
        dateLabelText: 'Date',
        timeLabelText: "Hour",
        selectableDayPredicate: (date) {
          return true;
         },
        onChanged: (val) {
          setState(() {
            startTime = DateFormat("yyyy-MM-dd hh:mm").parse(val);
          });
        },
        validator: (val) {
          print('XX2 : $val');
          return null;
        },
        onSaved: (val) => print('XX3 : $val'),
      )
    );
  }

    _endTimePicker(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (builder)=>
      DateTimePicker(
        type: DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        initialValue: startTime.toString(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        icon: const Icon(Icons.event),
        dateLabelText: 'Date',
        timeLabelText: "Hour",
        selectableDayPredicate: (date) {
          return true;
         },
        onChanged: (val) {
          setState(() {
            endTime = DateFormat("dd-MM-yyyy hh:mm").parse(val);
          });
        },
        validator: (val) {
          print('XX2 : $val');
          return null;
        },
        onSaved: (val) => print('XX3 : $val'),
      )
    );
  }
}
