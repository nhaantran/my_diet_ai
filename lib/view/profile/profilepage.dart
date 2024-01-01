import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/common/values/goal.dart';
import 'package:my_diet/view/welcome/pages/GoalWelcomePage.dart';
import 'package:my_diet/view/welcome/welcomebinding.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/toast.dart';
import '../home/homecontroller.dart';
import 'profilecontroller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.monochromatic09,
            title: const Text(
              "??",
              style: TextStyle(
                  color: AppColors.brand05,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600),
            )),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              SizedBox(
                height: 10.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_currentWeight(), _goalWeight()],
              ),
              SizedBox(height: 20.0.h),
              _updateHeight(),
              SizedBox(height: 20.0.h),
              _personal(context),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MaterialButton(
                        color: AppColors.error,
                        onPressed: () async {
                          await controller.onLogOut();
                        },
                        child: const Text(
                          "Log out",
                          style: TextStyle(color: AppColors.white),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20.0.h),
            ])));
  }

  Widget _updateHeight() {
    final RulerPickerController rulerPickerController =
        RulerPickerController(value: 150);
    return Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            width: 336.w,
            height: 250.h,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current height",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: AppColors.fontMid,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: RulerPicker(
                        controller: rulerPickerController,
                        beginValue: 100,
                        endValue: 220,
                        initValue: int.parse(HomeController.userHealth!.height),
                        onBuildRulerScalueText: (index, scaleValue) {
                          return scaleValue.toString();
                        },
                        scaleLineStyleList: const [
                          ScaleLineStyle(
                              color: AppColors.brand07,
                              width: 2,
                              height: 40,
                              scale: 0),
                          ScaleLineStyle(
                              color: AppColors.brand07,
                              width: 1,
                              height: 25,
                              scale: 5),
                          ScaleLineStyle(
                              color: AppColors.brand07,
                              width: 0,
                              height: 0,
                              scale: -1),
                        ],
                        onValueChange: (value) => {
                          controller.changeHeight(
                            value,
                          )
                        },

                        width: 335.w,
                        height: 100.h,
                        // rulerMarginTop: 8,
                        marker: Container(
                            width: 8,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.brand05.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                              style: const TextStyle(fontFamily: "Gothic"),
                              children: <TextSpan>[
                                TextSpan(
                                  text: HomeController.height.value,
                                  style: const TextStyle(
                                      fontSize: 36,
                                      //color: AppColors.white,
                                      color: AppColors.brand05,
                                      fontFamily: "Gothic",
                                      fontWeight: FontWeight.w700),
                                ),
                                const TextSpan(
                                    text: " cm",
                                    style: TextStyle(
                                      color: AppColors.brand05,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ]),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.brand05),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: AppColors.brand05)))),
                        onPressed: () {
                          HomeController.updateHeight(
                              int.parse(HomeController.height.value));
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 13.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ])));
  }

  Widget _currentWeight() {
    final RulerPickerController rulerPickerController =
        RulerPickerController(value: 150);
    return Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: 160.w,
          height: 90.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Current weight",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    color: AppColors.fontMid,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(fontFamily: "Gothic"),
                        children: <TextSpan>[
                          TextSpan(
                            text: HomeController.weight.value,
                            style: const TextStyle(
                                fontSize: 36,
                                //color: AppColors.white,
                                color: AppColors.brand05,
                                fontFamily: "Gothic",
                                fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(
                              text: " kg",
                              style: TextStyle(
                                color: AppColors.brand05,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                        ]),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          title: const Text("Update weight"),
                          content: Obx(() => SizedBox(
                                height: 250.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: RulerPicker(
                                        controller: rulerPickerController,
                                        beginValue: 40,
                                        endValue: 200,
                                        initValue: int.parse(
                                            HomeController.weight.value),
                                        onBuildRulerScalueText:
                                            (index, scaleValue) {
                                          return scaleValue.toString();
                                        },

                                        scaleLineStyleList: const [
                                          ScaleLineStyle(
                                              color: AppColors.brand07,
                                              width: 2,
                                              height: 40,
                                              scale: 0),
                                          ScaleLineStyle(
                                              color: AppColors.brand07,
                                              width: 1,
                                              height: 25,
                                              scale: 5),
                                          ScaleLineStyle(
                                              color: AppColors.brand07,
                                              width: 0,
                                              height: 0,
                                              scale: -1),
                                        ],
                                        onValueChange: (value) => {
                                          controller.changeWeight(
                                            value,
                                          )
                                        },

                                        width: 200,
                                        height: 100,
                                        // rulerMarginTop: 8,
                                        marker: Container(
                                            width: 8,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: AppColors.brand05
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    Text(
                                      "${HomeController.weight.value} kg",
                                      style: const TextStyle(
                                          color: AppColors.brand03,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60),
                                    ),
                                  ],
                                ),
                              )),
                          actions: [
                            TextButton(
                                child: const Text("Close",
                                    style: TextStyle(color: AppColors.error)),
                                onPressed: () {
                                  Get.back();
                                  HomeController.weight.value =
                                      HomeController.currentWeight.value;
                                }),
                            TextButton(
                                child: const Text("Ok"),
                                onPressed: () async {
                                  await HomeController.updateWeight(
                                      int.parse(HomeController.weight.value));
                                  Get.back();
                                  toastInfo(msg: "Update weight successful");
                                }),
                          ],
                        ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.fontMid,
                      ))
                ],
              ),
            ],
          ),
        ));
  }

  Widget _goalWeight() {
    return Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: 160.w,
          height: 90.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Goal weight",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    color: AppColors.fontMid,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(fontFamily: "Gothic"),
                        children: <TextSpan>[
                          TextSpan(
                            text: HomeController.userHealth!.goalWeight,
                            style: const TextStyle(
                                fontSize: 36,
                                //color: AppColors.white,
                                color: AppColors.brand05,
                                fontFamily: "Gothic",
                                fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(
                              text: " kg",
                              style: TextStyle(
                                color: AppColors.brand05,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                        ]),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.setRulerValue();
                        Get.dialog(AlertDialog(
                          title: const Text("Update goal weight"),
                          content: Obx(() => SizedBox(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: RulerPicker(
                                        controller: controller
                                            .rulerPickerController.value,
                                        beginValue: controller.beginValue.value,
                                        endValue: controller.endValue.value,
                                        initValue: int.parse(
                                            HomeController.weight.value),
                                        onBuildRulerScalueText:
                                            (index, scaleValue) {
                                          return scaleValue.toString();
                                        },

                                        scaleLineStyleList: const [
                                          ScaleLineStyle(
                                              color: AppColors.brand07,
                                              width: 2,
                                              height: 40,
                                              scale: 0),
                                          ScaleLineStyle(
                                              color: AppColors.brand07,
                                              width: 1,
                                              height: 25,
                                              scale: 5),
                                          ScaleLineStyle(
                                              color: AppColors.brand07,
                                              width: 0,
                                              height: 0,
                                              scale: -1),
                                        ],
                                        onValueChange: (value) => {
                                          controller.changeGoalWeight(
                                            value,
                                          )
                                        },
                                        width: 200,
                                        height: 100,
                                        // rulerMarginTop: 8,
                                        marker: Container(
                                            width: 8,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: AppColors.brand05
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    Text(
                                      "${HomeController.goalWeight.value} kg",
                                      style: const TextStyle(
                                          color: AppColors.brand03,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60),
                                    ),
                                  ],
                                ),
                              )),
                          actions: [
                            TextButton(
                                child: const Text("Close",
                                    style: TextStyle(color: AppColors.error)),
                                onPressed: () {
                                  Get.back();
                                  HomeController.weight.value =
                                      HomeController.currentWeight.value;
                                }),
                            TextButton(
                                child: const Text("Ok"),
                                onPressed: () async {
                                  await HomeController.updateGoalWeight(
                                      int.parse(
                                          HomeController.goalWeight.value));
                                  Get.back();
                                  toastInfo(msg: "Update goal successful");
                                }),
                          ],
                        ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.fontMid,
                      ))
                ],
              ),
            ],
          ),
        ));
  }

  Widget _personal(BuildContext context) {
    return Material(
      elevation: 2,
      color: AppColors.white,
      shadowColor: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      child: Expanded(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            width: 336.w,
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.success,
                        size: 32.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Personal details",
                        style: TextStyle(
                            color: AppColors.fontDark,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Gothic"),
                      )
                    ]),
                ListTile(
                  //tileColor: AppColors.fontMid,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(fontFamily: "Gothic"),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: "Current Goal: ",
                                  style: TextStyle(
                                    color: AppColors.fontMid,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                              TextSpan(
                                text: HomeController.goal.value ==
                                        Goal.maintenance
                                    ? "STAY HEALTHY"
                                    : HomeController.goal.value ==
                                            Goal.loseWeight
                                        ? "LOSE WEIGHT"
                                        : "GAIN WEIGHT",
                                //text: HomeController.height.value,
                                style: const TextStyle(
                                    fontSize: 18,
                                    //color: AppColors.white,
                                    color: AppColors.brand05,
                                    fontFamily: "Gothic",
                                    fontWeight: FontWeight.w700),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controller.openBottomPickerGoal(context);
                    },
                  ),
                  iconColor: AppColors.fontMid,
                ),
                ListTile(
                  //tileColor: AppColors.fontMid,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(fontFamily: "Gothic"),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: "Activity Level: ",
                                  style: TextStyle(
                                    color: AppColors.fontMid,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                              TextSpan(
                                text: HomeController.userHealth!.exercise
                                    .toUpperCase(),
                                //text: HomeController.height.value,
                                style: const TextStyle(
                                    fontSize: 18,
                                    //color: AppColors.white,
                                    color: AppColors.brand05,
                                    fontFamily: "Gothic",
                                    fontWeight: FontWeight.w700),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controller.openBottomPickerGoal(context);
                    },
                  ),
                  iconColor: AppColors.fontMid,
                ),
                ListTile(
                  //tileColor: AppColors.fontMid,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(fontFamily: "Gothic"),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: "Age: ",
                                  style: TextStyle(
                                    color: AppColors.fontMid,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                              TextSpan(
                                text: HomeController.userHealth!.age
                                    .toUpperCase(),
                                //text: HomeController.height.value,
                                style: const TextStyle(
                                    fontSize: 18,
                                    //color: AppColors.white,
                                    color: AppColors.brand05,
                                    fontFamily: "Gothic",
                                    fontWeight: FontWeight.w700),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controller.openBottomPickerGoal(context);
                    },
                  ),
                  iconColor: AppColors.fontMid,
                ),
                ListTile(
                  //tileColor: AppColors.fontMid,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: const TextStyle(fontFamily: "Gothic"),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: "Gender: ",
                                  style: TextStyle(
                                    color: AppColors.fontMid,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                              TextSpan(
                                text: HomeController.userHealth!.gender
                                    .toUpperCase(),
                                //text: HomeController.height.value,
                                style: const TextStyle(
                                    fontSize: 18,
                                    //color: AppColors.white,
                                    color: AppColors.brand05,
                                    fontFamily: "Gothic",
                                    fontWeight: FontWeight.w700),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      controller.openBottomPickerGoal(context);
                    },
                  ),
                  iconColor: AppColors.fontMid,
                ),
                // ListTile(
                //   //tileColor: AppColors.fontMid,
                //   titleAlignment: ListTileTitleAlignment.center,
                //   title: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Obx(
                //         () => RichText(
                //           text: TextSpan(
                //               style: const TextStyle(fontFamily: "Gothic"),
                //               children: <TextSpan>[
                //                 const TextSpan(
                //                     text: "Current activity: ",
                //                     style: TextStyle(
                //                       color: AppColors.fontMid,
                //                       fontSize: 14,
                //                       fontWeight: FontWeight.w500,
                //                     )),
                //                 TextSpan(
                //                   text: HomeController.userHealth!.exercise
                //                       .toUpperCase(),

                //                   style: const TextStyle(
                //                       fontSize: 18,
                //                       //color: AppColors.white,
                //                       color: AppColors.brand05,
                //                       fontFamily: "Gothic",
                //                       fontWeight: FontWeight.w700),
                //                 ),
                //               ]),
                //         ),
                //       ),
                //     ],
                //   ),
                //   trailing: IconButton(
                //     icon: const Icon(Icons.edit),
                //     onPressed: () {},
                //   ),
                //   iconColor: AppColors.fontMid,
                // ),
              ],
            )),
      ),
    );
  }
}
