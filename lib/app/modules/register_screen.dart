import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/voter_model.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/widgets/button_rounder.dart';
import 'package:vku_vote/app/widgets/input_text.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({ Key? key }) : super(key: key);
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
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(6.0.widthP),
            child: Form(
              key: homeController.formKey3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  foxLogo,
                  SizedBox(height: 10.0.widthP),
                  Text("Đăng nhập với ví MetaMask",style: TextStyle(
                    fontSize: 15.0.sizeP,
                    fontWeight: FontWeight.w600
                  )),
                  SizedBox(height: 8.0.widthP),
                  InputText(
                    controller: homeController.editController1,
                    labelVaidate: "Vui lòng nhập private key",
                    label: "Mã riêng (Private key)",
                  ),
                   SizedBox(height: 8.0.widthP),
                  InputText(
                    controller: homeController.editController2,
                    labelVaidate: "Vui lòng chọn tên đại diện",
                    label: "Tên đại diện",
                  ),
                  SizedBox(height: 5.0.widthP),
                  ButtonRouder(label: "Đăng nhập",onTap: () async {
                    if(homeController.formKey2.currentState!.validate()) {
                      try {
                        var success = homeController.login(Voter(
                        token: homeController.editController1.text, 
                        name: homeController.editController2.text, 
                        authorised: true
                      ));
                       Get.back();
                       await  success ? EasyLoading.showSuccess("Bạn đã đăng nhập với tài khoản đã được đăng ký") : EasyLoading.showSuccess("Đăng nhập lần đầu thành công");
                      } catch (e) {
                        EasyLoading.showError("Key không hợp lệ");
                      }
                    }
                  }),
                  SizedBox(height: 5.0.widthP),
                  TextButton(onPressed: (){
                    Get.back();
                    homeController.textFieldClear();
                  }, 
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  child: Text("Đăng nhập với tên ngẫu nhiên",style: TextStyle(
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