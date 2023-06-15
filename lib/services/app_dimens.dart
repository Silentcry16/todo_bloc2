import 'package:get/get.dart';

class Dimensions {
  static double screenHeight =
      Get.context!.height; //calculated based on height: 759
  static double screenwidth =
      Get.context!.width; //calculated based on  width: 392

  static double pageView = screenHeight / 2.37;
  static double pageViewContainer = screenHeight / 3.45;
  static double pageViewTextContainer = screenHeight / 5.8;

//dynamic height padding and margin
  static double height5 = screenHeight / 151.8;
  static double height10 = screenHeight / 75.9;
  static double height15 = screenHeight / 50.6;
  static double height20 = screenHeight / 37.95;
  static double height25 = screenHeight / 30.36;
  static double height30 = screenHeight / 25.3;
  static double height35 = screenHeight / 21.68;
  static double height40 = screenHeight / 18.97;
  static double height45 = screenHeight / 16.86;

//dynamic width padding and margin
  static double width5 = screenHeight / 151.8;
  static double width10 = screenHeight / 75.9;
  static double width15 = screenHeight / 50.6;
  static double width20 = screenHeight / 37.95;
  static double width25 = screenHeight / 30.36;
  static double width30 = screenHeight / 25.3;
  static double width35 = screenHeight / 21.68;
  static double width40 = screenHeight / 18.97;
  static double width45 = screenHeight / 16.86;
//font size
  static double font16 = screenHeight / 47.43;
  static double font20 = screenHeight / 37.95;
  static double font26 = screenHeight / 29.19;

//icon size
  static double iconSize24 = screenHeight / 31.625;
  static double iconSize16 = screenHeight / 47.43;

// radius
  static double radius15 = screenHeight / 50.6;
  static double radius20 = screenHeight / 37.95;
  static double radius30 = screenHeight / 25.3;

// listview size
  static double listViewImgSize = screenwidth / 3.26;
  static double listViewTextContSize = screenwidth / 3.92;

//popular food
  static double popularFoodImgSize = screenHeight / 2.16;

//botom height
  static double bottomHeight = screenHeight / 6.32;
}
