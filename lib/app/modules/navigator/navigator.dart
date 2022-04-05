import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';
import 'package:vku_vote/app/modules/home/home_screen.dart';
import 'package:vku_vote/app/modules/login/login_screen.dart';
import 'package:vku_vote/app/modules/profile/profile_screen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({ Key? key }) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int selectedIndex = 0;
  final pageController = PageController();
  final homeController = Get.find<HomeController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=> PageView(
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          onPageChanged: (index){
            setState(() {
              selectedIndex = index;
            });
          },
          children: [
            const HomeScreen(),
            homeController.isLogin.value ? ProfileScreen() : LoginScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: primaryColor
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: primaryColor
        ),
        selectedIconTheme: IconThemeData(
          color: primaryColor,
          size: 20.0.sizeP
        ),
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_vote_outlined),
            label: "Phòng"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Ví của tôi"
          )
        ],
        onTap: (index){
          setState(() {
            pageController.jumpToPage(index);
            selectedIndex = index;
          });
          print(selectedIndex);
        },
        ),
    );
  }
}