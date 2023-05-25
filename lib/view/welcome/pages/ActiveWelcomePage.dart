// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../welcomepage.dart';
import '../widgets/WelcomeCard.dart';

class ActiveWelcomePage extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback back;
  var selectedIndex = 4.obs;
  ActiveWelcomePage({
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
                visible: selectedIndex != 4,
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
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/images/gym.jpg"),
                //         fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "How active are you?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Gothic',
                          fontWeight: FontWeight.w900),
                    ),
                    // currentPageIndex = _pageController.page!.round();
                    //     movingNextPage(_pageController, currentPageIndex);
                    ComplexButtonCard(
                      onTap: () {
                        onTap();
                        changeStatus(0);
                      },
                      backgroundColor: selectedIndex.value == 0
                          ? AppColors.brand05
                          : Colors.white,
                      textColor: selectedIndex.value == 0
                          ? Colors.white
                          : AppColors.brand05,
                      iconAssets: AssetImage("assets/icons/sedentary.png"),
                      title: "Not very active",
                      description: "I have a sedentary lifestyle.",
                      example: "E.g. desk job, bank teller",
                    ),
                    ComplexButtonCard(
                      onTap: () {
                        onTap();
                        changeStatus(1);
                      },
                      backgroundColor: selectedIndex.value == 1
                          ? AppColors.brand05
                          : Colors.white,
                      textColor: selectedIndex.value == 1
                          ? Colors.white
                          : AppColors.brand05,
                      iconAssets:
                          AssetImage("assets/icons/moderately_active.png"),
                      title: "Moderately active",
                      description: "I spend a good part of the day on my feet.",
                      example: "E.g teacher, salesperson",
                    ),
                    ComplexButtonCard(
                      onTap: () {
                        onTap();
                        changeStatus(2);
                      },
                      backgroundColor: selectedIndex.value == 2
                          ? AppColors.brand05
                          : Colors.white,
                      textColor: selectedIndex.value == 2
                          ? Colors.white
                          : AppColors.brand05,
                      iconAssets: AssetImage("assets/icons/active.png"),
                      title: "Active",
                      description:
                          "I spend a good part of the day walking or doing some physical activity.",
                      example: "E.g waiter, nurse",
                    ),
                    ComplexButtonCard(
                      onTap: () {
                        onTap();
                        changeStatus(3);
                      },
                      backgroundColor: selectedIndex.value == 3
                          ? AppColors.brand05
                          : Colors.white,
                      textColor: selectedIndex.value == 3
                          ? Colors.white
                          : AppColors.brand05,
                      iconAssets: AssetImage("assets/icons/very_active.png"),
                      title: "Very active",
                      description:
                          "I spend most of the day doing heavy physical work or activity.",
                      example: "E.g carpenter, construction worker",
                    ),
                  ],
                )))));
  }
}
