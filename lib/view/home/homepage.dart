// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:my_diet/common/values/colors.dart';

import '../../common/entities/user.dart';
import 'homecontroller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // _profileCustomer(),
          SizedBox(
            height: 50.h,
          ),
          topBar(),
          SizedBox(
            height: 10.h,
          ),
          _caloriesCounter(),
          SizedBox(
            height: 20.h,
          ),
          _streakCounter(),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_waterCounter(), _updateWeight()],
          )
        ],
      ),
    );
  }

  Widget topBar() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/icons/logo_my_diet.png",
                  ),
                )),
            RichText(
              text: const TextSpan(
                  style: TextStyle(fontFamily: "Gothic"),
                  children: <TextSpan>[
                    TextSpan(
                        text: " M",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                        text: "y",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                        text: "D",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                        text: "i",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                        text: "e",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                        text: "t ",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                  ]),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          color: AppColors.brand05,
          onPressed: () {},
        ),
      ]),
    );
  }

  Widget _updateWeight() {
    Get.put(WelcomeController());
    return Material(
        elevation: 2,
        color: AppColors.purple,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            padding: EdgeInsets.all(20.0),
            width: 160.w,
            height: 145.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Current weight",
                    style: TextStyle(
                        fontSize: 20,
                        //color: AppColors.white,

                        color: Color(0xffD3D5F7),
                        fontFamily: "Gothic",
                        fontWeight: FontWeight.w600)),
                GetX<WelcomeController>(builder: (controller) {
                  return RichText(
                      text: TextSpan(
                          style: const TextStyle(fontFamily: "Gothic"),
                          children: <TextSpan>[
                        TextSpan(
                          text: controller.weight.value.toString(),
                          style: const TextStyle(
                              fontSize: 50,
                              //color: AppColors.white,
                              color: Color(0xffE2E3F9),
                              fontFamily: "Gothic",
                              fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(
                            text: " kg",
                            style: TextStyle(
                              color: Color(0xffE2E3F9),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                      ]));
                }),
                SizedBox(
                  height: 30.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffD3D5F7)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Color(0xff5D66E0))))),
                    onPressed: () {
                      //controller.handleSignIn();
                    },
                    child: const Text(
                      'Update weight',
                      style: TextStyle(
                        color: Color(0xff181F7F),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget _waterCounter() {
    return Material(
      elevation: 2,
      color: AppColors.white,
      shadowColor: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      child: Container(
          padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          width: 160.w,
          height: 145.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                RichText(
                    text: TextSpan(
                        style: const TextStyle(fontFamily: "Gothic"),
                        children: <TextSpan>[
                      TextSpan(
                        text: "${controller.waterIntake}",
                        style: const TextStyle(
                            fontSize: 28,
                            color: AppColors.brand05,
                            fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                          text: " / ${controller.waterNeeded}l",
                          style: const TextStyle(
                            color: AppColors.fontMid,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          )),
                    ])),
              ]),
              Padding(
                padding: EdgeInsets.only(
                  top: 0.0.h,
                ),
                child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: Stack(
                      children: [
                        Positioned(
                            child: Image.asset(
                          "assets/icons/water.png",
                          width: 100.w,
                        )),
                        Positioned(
                            right: 10.w,
                            bottom: 5.h,
                            child: IconButton(
                              iconSize: 32,
                              icon: const Icon(
                                Icons.add_circle,
                                color: AppColors.success,
                              ),
                              onPressed: () {},
                            )),
                      ],
                    )),
              ),
            ],
          )),
    );
  }

  Widget _streakCounter() {
    return Obx(() => Material(
          elevation: 2,
          color: AppColors.green,
          shadowColor: Color(0xff00F787),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: 336.w,
            height: 145.h,
            alignment: Alignment.topLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/icons/streak.png",
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${controller.streaks}",
                            style: const TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w900,
                                fontSize: 80,
                                color: Color(0xff187f56))),
                        const Text(
                          "day streak",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Color(0xff187f56),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  Widget _caloriesCounter() {
    return Obx(() => Material(
          elevation: 2,
          color: AppColors.brand06,
          shadowColor: AppColors.brand06,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: 336.w,
            height: 145.h,
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Eaten",
                          style: TextStyle(
                            color: Color(0xffcccccc),
                            fontFamily: "Gothic",
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "${controller.caloriesFood.value}",
                              style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: "Gothic",
                                fontWeight: FontWeight.w900,
                                fontSize: 48,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  " kcal",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Gothic",
                                    fontSize: 20,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Remaining",
                          style: TextStyle(
                            color: AppColors.brand05,
                            fontFamily: "Gothic",
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "${controller.baseGoal}",
                              //"${controller.baseGoal.value - controller.caloriesFood.value}",
                              //"${WelcomeController.user!.basalMetabolicRate.hb.calories.value.toInt() - controller.caloriesFood.value}",
                              style: const TextStyle(
                                color: AppColors.brand05,
                                fontFamily: "Gothic",
                                fontWeight: FontWeight.w900,
                                fontSize: 48,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    trailing: Image.asset("assets/icons/destination.png"),
                    lineHeight: 10.h,
                    backgroundColor: AppColors.brand05,
                    progressColor: AppColors.white,
                    percent: 0.5,
                    //controller.caloriesFood.value / 100,
                        // WelcomeController
                        //     .user!.basalMetabolicRate.hb.calories.value,
                    animateFromLastPercent: true,
                    barRadius: Radius.circular(10),
                    animation: true,
                    restartAnimation: false,
                  ),
                )
              ],
            ),
          ),
        ));
    // return Container(
    //   margin: EdgeInsets.all(0.0),
    //   color: AppColors.white,
    //   child: Row(children: [
    //     RichText(
    //       text: const TextSpan(
    //         text: "Calories\n",
    //         style: TextStyle(
    //             fontFamily: "OpenSans",
    //             color: AppColors.fontDark,
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     RichText(
    //       text: const TextSpan(
    //         text: "Remaining = Goal - Food + Exercise",
    //         style: TextStyle(
    //             fontFamily: "OpenSans",
    //             color: AppColors.fontDark,
    //             fontSize: 8,
    //             fontWeight: FontWeight.w400),
    //       ),
    //     )
    //   ]),
    // );
  }

  Widget _profileCustomer() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/images/bida.jpg",
                  fit: BoxFit.fill, width: 120, height: 120),
              //CachedNetworkImage(imageUrl: "${item.photourl}"),
            ),
          ),
          Text(
            //"${item.name}",
            "Tran Thanh Nhan",
            style: const TextStyle(
                fontSize: 22,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w800),
          ),
          Text(
            //"${item.name}",
            "Normal member",
            style: const TextStyle(
                color: AppColors.brand05,
                fontSize: 16,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
