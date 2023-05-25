import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../common/values/colors.dart';
import 'profilecontroller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.monochromatic09,
          title: GetX<WelcomeController>(builder: ((controller) {
            return Text(
              "${controller.name}",
              style: const TextStyle(
                  color: AppColors.brand05,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600),
            );
          })),
        ),
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
              _personal(),
            ])));
  }

  Widget _currentWeight() {
    Get.put(WelcomeController());
    return Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10.0),
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
                  GetX<WelcomeController>(builder: ((controller) {
                    return RichText(
                      text: TextSpan(
                          style: const TextStyle(fontFamily: "Gothic"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${controller.weight}",
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
                    );
                  })),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.fontMid,
                      ))
                ],
              ),
            ],
          ),
        ));
  }

  Widget _goalWeight() {
    Get.put(WelcomeController());
    return Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10.0),
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
                  GetX<WelcomeController>(builder: ((controller) {
                    return RichText(
                      text: TextSpan(
                          style: const TextStyle(fontFamily: "Gothic"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${controller.goalWeight}",
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
                    );
                  })),
                  IconButton(
                      onPressed: () {},
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

  Widget _personal() {
    return Material(
      elevation: 2,
      color: AppColors.white,
      shadowColor: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      child: Container(
          padding: EdgeInsets.all(20.0),
          width: 336.w,
          height: 250.h,
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Icon(
                  Icons.person,
                  color: AppColors.success,
                  size: 32.0,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  "Personal",
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
                title: const Text("Personal details"),
                textColor: AppColors.fontMid,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
                iconColor: AppColors.fontMid,
              ),
              ListTile(
                //tileColor: AppColors.fontMid,
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Goals"),
                textColor: AppColors.fontMid,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
                iconColor: AppColors.fontMid,
              ),
              ListTile(
                //tileColor: AppColors.fontMid,
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Water"),
                textColor: AppColors.fontMid,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
                iconColor: AppColors.fontMid,
              ),
              ListTile(
                //tileColor: AppColors.fontMid,
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Activity"),
                textColor: AppColors.fontMid,
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
                iconColor: AppColors.fontMid,
              ),
            ],
          )),
    );
  }

  Widget _currentHeight() {
    Get.put(WelcomeController());
    return Material(
        elevation: 2,
        color: AppColors.white,
        shadowColor: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10.0),
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
                  GetX<WelcomeController>(builder: ((controller) {
                    return RichText(
                      text: TextSpan(
                          style: const TextStyle(fontFamily: "Gothic"),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${controller.weight}",
                              style: const TextStyle(
                                  fontSize: 36,
                                  //color: AppColors.white,
                                  color: AppColors.fontDark,
                                  fontFamily: "Gothic",
                                  fontWeight: FontWeight.w700),
                            ),
                            const TextSpan(
                                text: " kg",
                                style: TextStyle(
                                  color: AppColors.fontDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                )),
                          ]),
                    );
                  })),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.fontMid,
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
