import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.widthP;
    return Container(
      margin: EdgeInsets.only(top: 10.0.widthP),
      width: squareWidth,
      height: squareWidth/2.3,
      padding: EdgeInsets.symmetric(horizontal: 3.0.widthP),
      decoration: BoxDecoration(
        color: whiteColor,
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("78.0 ETH",style: TextStyle(
                  fontSize: 15.0.sizeP,
                  fontWeight: FontWeight.w700
                )),
                SizedBox(height: 3.0.widthP),
                Row(
                  children: [
                    Container(
                      width: 20.0.widthP,
                      height: 10.0.widthP,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent)
                        ),
                        onPressed: (){}, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Mua",style: TextStyle(
                              fontSize: 10.0.sizeP,
                              color: whiteColor,
                              fontWeight: FontWeight.bold
                            )),
                            const Icon(Icons.trending_up_outlined,color: whiteColor)
                          ],
                        )
                      ),
                    ),
                    SizedBox(width: 2.0.widthP),
                    Container(
                      width: 20.0.widthP,
                      height: 10.0.widthP,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.transparent)
                        ),
                        onPressed: (){}, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Gửi",style: TextStyle(
                              fontSize: 10.0.sizeP,
                              color: whiteColor,
                              fontWeight: FontWeight.bold
                            )),
                            const Icon(Icons.trending_down_outlined,color: whiteColor)
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 2.0.widthP),
          Lottie.network('https://assets4.lottiefiles.com/packages/lf20_9cl7qlhz.json',width: 35.0.widthP),
        ],
      ),
    );
  }
}