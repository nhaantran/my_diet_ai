import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/food/foodcontroller.dart';

import '../../common/values/colors.dart';

class FoodPage extends GetView<FoodController> {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _tabBar(),
              _tabBarView(),
            ]));
  }

  Widget _tabBar() {
    return Center(
      child: Container(
        height: 48.h,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabBar(
              isScrollable: true,
              labelColor: AppColors.white,
              controller: controller.tabController,
              unselectedLabelColor: AppColors.fontDark,
              indicator: BoxDecoration(
                color: AppColors.brand05,
                borderRadius: BorderRadius.circular(24),
              ),
              tabs: const [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "My Foods",
                ),
                Tab(
                  text: "My Meals",
                ),
                Tab(
                  text: "My Receipe",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _functionAddFoodItem(String title, AssetImage icon, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 160.w,
        height: 98.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  onTap();
                },
                iconSize: 48.0,
                icon: ImageIcon(
                  icon,
                  color: AppColors.brand07,
                  size: 48.0,
                )),
            Text(
              title,
              style: const TextStyle(
                  color: AppColors.brand07,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        )),
      ),
    );
  }

  Widget _functionAddFood(
      String leftTitle,
      AssetImage leftIcon,
      Function leftTap,
      String rightTitle,
      AssetImage rightIcon,
      Function rightTap) {
    return Container(
      height: 145.h,
      color: AppColors.brand10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _functionAddFoodItem(leftTitle, leftIcon, leftTap),
          _functionAddFoodItem(rightTitle, rightIcon, rightTap),
        ],
      ),
    );
  }

  scanMealFunction() {
    print("Scan meal");
  }

  scanBarCodeFunction() {
    print("Scan bar code");
  }

  createFoodFunction() {
    print("Create food");
  }

  createMealFunction() {
    print("Create meal");
  }

  createRecipeFunction() {
    print("Create recipe");
  }

  discoverFunction() {
    print("Discover...");
  }

  Widget _tabBarView() {
    return Container(
      width: double.infinity,
      height: 145.h,
      child: TabBarView(controller: controller.tabController, children: [
        _functionAddFood(
            "Scan food",
            const AssetImage("assets/icons/scan_food.png"),
            scanMealFunction,
            "Scan barcode",
            const AssetImage("assets/icons/scan_barcode.png"),
            scanBarCodeFunction),
        _functionAddFood(
            "Create a food",
            const AssetImage("assets/icons/create_food.png"),
            createFoodFunction,
            "Discover new food",
            const AssetImage("assets/icons/discover_food.png"),
            discoverFunction),
        _functionAddFood(
            "Create a meal",
            const AssetImage("assets/icons/create_meal.png"),
            createMealFunction,
            "Discover new meal",
            const AssetImage("assets/icons/discover_food.png"),
            discoverFunction),
        _functionAddFood(
            "Create a recipe",
            const AssetImage("assets/icons/create_recipe.png"),
            createRecipeFunction,
            "Discover new recipe",
            const AssetImage("assets/icons/discover_food.png"),
            discoverFunction),
      ]),
    );
  }
}
