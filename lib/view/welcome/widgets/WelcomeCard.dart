// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../welcomecontroller.dart';

class SimpleButtonCard extends GetView<WelcomeController> {
  SimpleButtonCard({
    Key? key,
    required this.onTap,
    required this.iconAssets,
    required this.buttonText,
    this.index,
  }) : super(key: key);

  final AssetImage iconAssets;
  final String buttonText;
  Function onTap;
  final _color = Colors.white.obs;
  int? index;
  final isTaped = false.obs;
  var isClicked = false;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find<ButtonController>();
    // final color = controller.isTapped.value ? AppColors.brand06 : Colors.white;
    //final color = controller.color.value;
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Obx(() => InkWell(
              onTap: () {
                onTap();
                isTaped.toggle();
              },
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 5.w),
                height: 90.0.h,
                width: 300.0.w,
                decoration: BoxDecoration(
                  color: isTaped.isTrue ? AppColors.brand05 : Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        buttonText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            color: isTaped.isTrue
                                ? Colors.white
                                : AppColors.brand05,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      height: 48.0.w,
                      width: 48.0.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: iconAssets, fit: BoxFit.fill)),
                      child: SizedBox(
                        width: 54.w,
                        height: 54.w,
                        // child: ImageIcon(
                        //   iconAssets,
                        // ),
                        // child: CachedNetworkImage(
                        //   imageUrl: "${item.photourl}",
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class ComplexButtonCard extends GetView<WelcomeController> {
  ComplexButtonCard({
    Key? key,
    required this.iconAssets,
    required this.onTap,
    required this.title,
    required this.description,
    required this.example,
    this.index,
  }) : super(key: key);

  final AssetImage iconAssets;
  final String title;
  final String description;
  final String example;
  final Function onTap;
  final _color = Colors.white.obs;
  int? index;
  var isTaped = false.obs;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find<ButtonController>();
    // final color = controller.isTapped.value ? AppColors.brand06 : Colors.white;
    //final color = controller.color.value;
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Obx(() => InkWell(
              onTap: () {
                onTap();
                isTaped.toggle();
              },
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 5.w),
                height: 90.0.h,
                width: 300.0.w,
                decoration: BoxDecoration(
                  color: isTaped.isTrue ? AppColors.brand05 : Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isTaped.isTrue
                                            ? Colors.white
                                            : AppColors.brand05,
                                        fontWeight: FontWeight.w900))),
                            RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: description,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isTaped.isTrue
                                            ? Colors.white
                                            : AppColors.brand05,
                                        fontWeight: FontWeight.w400))),
                            RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: example,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isTaped.isTrue
                                            ? Colors.white
                                            : AppColors.brand05,
                                        fontWeight: FontWeight.w300)))
                          ]),
                      // child: Text(
                      //   buttonText,
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       fontSize: 15,
                      //       color: isTaped.isTrue
                      //           ? Colors.white
                      //           : AppColors.brand05,
                      //       fontWeight: FontWeight.w900),
                      // ),
                    ),
                    Container(
                      height: 48.0.w,
                      width: 48.0.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: iconAssets, fit: BoxFit.fill)),
                      child: SizedBox(
                        width: 54.w,
                        height: 54.w,
                        // child: ImageIcon(
                        //   iconAssets,
                        // ),
                        // child: CachedNetworkImage(
                        //   imageUrl: "${item.photourl}",
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class VeryComplexButtonCard extends GetView<WelcomeController> {
  VeryComplexButtonCard({
    Key? key,
    required this.iconAssets,
    required this.onTap,
    required this.title,
    required this.description,
    required this.example,
    this.index,
    required this.percentage,
    required this.duration,
    required this.difficulty,
    required this.weightLoss,
  }) : super(key: key);

  final AssetImage iconAssets;
  final String title;
  final String description;
  final String example;
  final Function onTap;
  final String duration;
  final int difficulty;
  final double weightLoss;
  int percentage;
  final _color = Colors.white.obs;
  int? index;
  var isTaped = false.obs;

  // column -> richtext
  //        -> row -> column  -> row
  //                          -> row -> 2 column
  //               -> image

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find<ButtonController>();
    // final color = controller.isTapped.value ? AppColors.brand06 : Colors.white;
    //final color = controller.color.value;
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Obx(() => InkWell(
              onTap: () {
                onTap();
                isTaped.toggle();
              },
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 5.w),
                height: 90.0.h,
                width: 300.0.w,
                decoration: BoxDecoration(
                  color: isTaped.isTrue ? AppColors.brand05 : Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, right: 20, bottom: 10),
                      alignment: Alignment.topRight,
                      child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                              text: "${percentage}% complete rate",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.brand05,
                                  fontWeight: FontWeight.w700))),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                            text: title,
                                            style: const TextStyle(
                                                fontFamily: "OpenSans",
                                                fontSize: 15,
                                                color: AppColors.brand01,
                                                fontWeight: FontWeight.w700))),
                                    RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                            text: " $duration months",
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontSize: 15,
                                                color: isTaped.isTrue
                                                    ? Colors.white
                                                    : AppColors.brand05,
                                                fontWeight: FontWeight.w600)))
                                  ],
                                ),
                              ),
                              Row(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: const TextSpan(
                                              text: "Progress",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.fontMid,
                                                  fontWeight:
                                                      FontWeight.w300))),
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                              text: "-$weightLoss kg/ week",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.brand02,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ],
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: const TextSpan(
                                              text: "Difficulty",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColors.fontMid,
                                                  fontWeight:
                                                      FontWeight.w300))),
                                      _buildDotIndicator(difficulty),
                                    ]),
                              ]),
                            ],
                          ),
                        ),
                        Container(
                          height: 48.0.w,
                          width: 48.0.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: iconAssets, fit: BoxFit.fill)),
                          child: SizedBox(
                            width: 54.w,
                            height: 54.w,
                            // child: ImageIcon(
                            //   iconAssets,
                            // ),
                            // child: CachedNetworkImage(
                            //   imageUrl: "${item.photourl}",
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildDotIndicator(int difficulty) {
    return DotsIndicator(
      mainAxisSize: MainAxisSize.min,
      position: difficulty,
      dotsCount: 5,
      reversed: false,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

// class SimpleButtonCard extends GetView<ButtonController> {
//   const SimpleButtonCard({
//     Key? key,
//     //required this.color,
//     required this.iconAssets,
//     required this.buttonText,
//     this.onTap,
//   }) : super(key: key);

//   final AssetImage iconAssets;
//   final String buttonText;
//   final Function()? onTap;
//   // final Color color;
//   // final bool isTaped = false;

//   @override
//   Widget build(BuildContext context) {
//     var _color = Colors.white;
//     Get.lazyPut(() => ButtonController());
//     //final controller = Get.find<ButtonController>();
//     // final color = controller.isTapped.value ? AppColors.brand06 : Colors.white;
//     //final color = controller.color.value;
//     return GestureDetector(
//       onTap: () {
//         if (_color == Colors.white) {
//           _color = AppColors.brand05;
//         } else
//           _color = Colors.white;
//         //_color == Colors.white ? AppColors.brand05 : Colors.white;
//         controller.changeColor(_color);
//         print(_color);
//       },
//       child: Container(
//         padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
//         child: Material(
//           elevation: 5.0,
//           borderRadius: BorderRadius.circular(20.0),
//           child: InkWell(
//             //onTap: onTap,
//             child: Container(
//               padding: EdgeInsets.only(left: 15.w, right: 5.w),
//               height: 90.0.h,
//               width: 300.0.w,
//               decoration: BoxDecoration(
//                 color: _color,
//                 //color: controller.color.value as Color?,
//                 // color: controller.isTapped.value == true
//                 //     ? AppColors.brand06
//                 //     : Colors.white,
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       buttonText,
//                       textAlign: TextAlign.left,
//                       style: const TextStyle(
//                           fontSize: 15,
//                           color: AppColors.brand05,
//                           fontWeight: FontWeight.w900),
//                     ),
//                   ),
//                   Container(
//                     height: 48.0.w,
//                     width: 48.0.w,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: iconAssets, fit: BoxFit.fill)),
//                     child: SizedBox(
//                       width: 54.w,
//                       height: 54.w,
//                       // child: ImageIcon(
//                       //   iconAssets,
//                       // ),
//                       // child: CachedNetworkImage(
//                       //   imageUrl: "${item.photourl}",
//                       // ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
