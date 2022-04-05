import 'package:get/get.dart';

extension PersenSize on double{
  double get widthP => (Get.width * (this / 100));
  double get heightP => (Get.height * (this / 100));
}

extension ReponsiveText on double{
  double get sizeP => (Get.width / 100 * (this/3));
}