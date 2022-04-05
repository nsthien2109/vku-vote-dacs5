import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/voter_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/modules/register_screen.dart';
import 'package:vku_vote/app/widgets/button_rounder.dart';
import 'package:vku_vote/app/widgets/input_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({ Key? key }) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/img/foxs.svg';
    final Widget foxLogo = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Fox',
      width: 130.0.sizeP,
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: blackColor
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(6.0.widthP),
            child: Form(
              key: homeController.formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  foxLogo,
                  SizedBox(height: 10.0.widthP),
                  Text("Đăng nhập ",style: TextStyle(
                    fontSize: 15.0.sizeP,
                    fontWeight: FontWeight.w600
                  )),
                  SizedBox(height: 8.0.widthP),
                  InputText(
                    controller: homeController.editController1,
                    labelVaidate: "Vui lòng nhập private key",
                    label: "Mã riêng (Private key)",
                  ),
                  SizedBox(height: 5.0.widthP),
                  ButtonRouder(label: "Đăng nhập",onTap: () async {
                    if(homeController.formKey2.currentState!.validate()){
                      try {
                        var success = homeController.login(Voter(
                        token: homeController.editController1.text, 
                        name: "", 
                        authorised: true
                      ));
                       await  success ? EasyLoading.showSuccess("Bạn đã đăng nhập với tài khoản đã được đăng ký") : EasyLoading.showSuccess("Đăng nhập lần đầu thành công");
                      } catch (e) {
                        EasyLoading.showError("Key không hợp lệ");
                      }
                    }
                  }),
                  SizedBox(height: 5.0.widthP),
                  TextButton(onPressed: (){
                    Get.to(()=> RegisterScreen());
                    homeController.textFieldClear();
                  }, 
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  child: Text("Đăng nhập với tên đại diện tại đây",style: TextStyle(
                        color: blackColor,
                        fontSize: 12.0.sizeP
                      )
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}