// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../welcomecontroller.dart';
import '../welcomepage.dart';
import '../widgets/WelcomeCard.dart';

class GenderWelcomePage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;
  var selectedIndex = 2.obs;
  GenderWelcomePage({
    Key? key,
    required this.onTap,
    required this.back,
  }) : super(key: key);

  void changeStatus(var index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visibility(
                  visible: true,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.brand09,
                    onPressed: () {
                      back();
                    },
                    child: Icon(Icons.arrow_back_ios_new),
                    foregroundColor: AppColors.brand05,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Visibility(
                  visible: selectedIndex != 2,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.brand05,
                    onPressed: () {
                      onTap();
                    },
                    child: Icon(Icons.arrow_forward_ios),
                    foregroundColor: AppColors.white,
                  ),
                )
              ],
            ),
          ),
          body: Center(
            child: Container(
                color: AppColors.monochromatic09,
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Which gender are you assigned at birth?",
                        style: TextStyle(
                            color: AppColors.brand02,
                            fontSize: 24,
                            fontFamily: 'Gothic',
                            fontWeight: FontWeight.w900),
                      ),
                      SimpleButtonCard(
                        backgroundColor: selectedIndex.value == 0
                            ? AppColors.brand05
                            : Colors.white,
                        textColor: selectedIndex.value == 0
                            ? Colors.white
                            : AppColors.brand05,
                        iconAssets: AssetImage("assets/icons/male.png"),
                        buttonText: "Male",
                        onTap: () {
                          onTap();
                          changeStatus(0);
                          controller.gender.value = "male";
                        },
                      ),
                      SimpleButtonCard(
                        backgroundColor: selectedIndex.value == 1
                            ? AppColors.brand05
                            : Colors.white,
                        textColor: selectedIndex.value == 1
                            ? Colors.white
                            : AppColors.brand05,
                        onTap: () {
                          onTap();
                          changeStatus(1);
                          controller.gender.value = "female";
                        },
                        iconAssets: AssetImage("assets/icons/female.png"),
                        buttonText: "Female",
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
