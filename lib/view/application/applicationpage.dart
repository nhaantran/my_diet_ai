import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/home/homepage.dart';
import 'package:my_diet/view/profile/profilepage.dart';

import '../../common/values/colors.dart';
import '../daily/dailypage.dart';
import '../food/foodpage.dart';
import 'applicationcontroller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  void _mainFunctionBottomSheet(context) {}

  Widget _buildPageView() {
    return PageView(
      reverse: false,
      controller: controller.pageController,
      onPageChanged: (index) => {controller.handlePageChanged(index)},
      physics: NeverScrollableScrollPhysics(),
      children: [
        HomePage(),
        DailyPage(),
        Container(),
        // Center(
        //   child: Text("4"),
        // ),

        ProfilePage(),
      ],
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          items: controller.bottomeTabs,
          iconSize: 36.0,
          currentIndex: controller.page.value,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => {controller.handleNavBarTap(value)},
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.tabBarElement,
          selectedItemColor: AppColors.thirdElementText,
        ));
  }

  _mainFunctionModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: 125,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column(
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {
                    //           print("ccjz");
                    //         },
                    //         iconSize: 48.0,
                    //         icon: ImageIcon(
                    //           AssetImage(
                    //               "assets/icons/suggested_food_function.png"),
                    //           color: AppColors.warning,
                    //           size: 48.0,
                    //         )),
                    //     Text(
                    //       "Suggest Food",
                    //       style: TextStyle(
                    //           fontSize: 10, fontWeight: FontWeight.w500),
                    //     )
                    //   ],
                    // ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            iconSize: 48.0,
                            icon: ImageIcon(
                              AssetImage(
                                  "assets/icons/connected_people_function.png"),
                              color: AppColors.neutral,
                              size: 48.0,
                            )),
                        Text(
                          "Connected to people",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.addFoodNavigation();
                            },
                            iconSize: 48.0,
                            icon: ImageIcon(
                              AssetImage("assets/icons/add_food_function.png"),
                              color: AppColors.error,
                              size: 48.0,
                            )),
                        Text(
                          "Add Food",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            iconSize: 48.0,
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage(
                                  "assets/icons/scan_bar_code_function.png"),
                              size: 48.0,
                            )),
                        Text(
                          "Scan bar-code",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.addExerciseNavigation();
                            },
                            iconSize: 48.0,
                            icon: ImageIcon(
                              AssetImage(
                                  "assets/icons/add_exercise_function.png"),
                              color: AppColors.success,
                              size: 48.0,
                            )),
                        Text(
                          "Add Exercise",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigation(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mainFunctionModalBottomSheet(context);
        },
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: AppColors.brand06),
            borderRadius: BorderRadius.circular(100)),
        backgroundColor: AppColors.white,
        child: Icon(
          Icons.add,
          size: 36.0,
        ),
        foregroundColor: AppColors.brand06,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
