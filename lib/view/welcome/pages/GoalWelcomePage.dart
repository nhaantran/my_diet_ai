// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/goal.dart';
import '../welcomecontroller.dart';
import '../welcomepage.dart';
import '../widgets/WelcomeCard.dart';

enum DietPlan {
  fatloss_moderate,
  fatloss_aggressive,
  fatloss_reckless,
  maintenance,
  bulking_slow,
  bulking_normal,
  bulking_aggressive
}

class GoalWelcomePage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;
  var selectedIndex = 3.obs;
  GoalWelcomePage({
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
                  visible: selectedIndex != 3,
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
                        "What's your goal?",
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
                        iconAssets: AssetImage("assets/icons/stayhealthy.png"),
                        buttonText: "Stay Healthy",
                        onTap: () {
                          onTap();
                          changeStatus(0);
                          controller.goal.value = Goal.maintenance;
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
                          controller.goal.value = Goal.loseWeight;
                        },
                        iconAssets: AssetImage("assets/icons/loseweight.png"),
                        buttonText: "Lose Weight",
                      ),
                      SimpleButtonCard(
                        backgroundColor: selectedIndex.value == 2
                            ? AppColors.brand05
                            : Colors.white,
                        textColor: selectedIndex.value == 2
                            ? Colors.white
                            : AppColors.brand05,
                        onTap: () {
                          onTap();
                          changeStatus(2);
                          controller.goal.value = Goal.gainWeight;
                        },
                        iconAssets: AssetImage("assets/icons/gainweight.png"),
                        buttonText: "Gain Weight",
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
