// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'package:my_diet/view/food/foodcontroller.dart';

import '../../common/routes/names.dart';
import '../../common/values/colors.dart';
import '../exercise/widget/ExerciseTile.dart';
import 'FoodTile.dart';

class FoodPage extends GetView<FoodController> {
  FoodPage(
    this.mealTime,
  );

  String mealTime;
  @override
  Widget build(BuildContext context) {
    if (mealTime != null) {
      controller.selectedMealTime.value = mealTime as String;
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.brand05,
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: Obx(
            () => DropdownButton(
              elevation: 0,
              iconEnabledColor: AppColors.brand05,
              value: controller.selectedMealTime.isEmpty
                  ? "Breakfast"
                  : controller.selectedMealTime.value,
              items: controller.mealTime
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                controller.onMealTimeChanged(value as String);
              },
              style: const TextStyle(color: AppColors.brand05, fontSize: 16),
            ),
          ),
          backgroundColor: AppColors.monochromatic09,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _tabBar(),
              Container(
                height: 60.h,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onEditingComplete: () {
                    controller.getData();
                    // print(controller.foodSearchController.text);
                  },
                  controller: controller.foodSearchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {},
                    ),
                    hintText: "Search food...",
                    alignLabelWithHint: true,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: AppColors.brand05),
                        borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                        ),
                  ),
                ),
              ),
              _tabBarView(),
              Expanded(
                  child: Container(
                color: AppColors.brand05,
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.startLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AlignedGridView.count(
                    itemCount: controller.foodList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return FoodTile(controller.foodList[index]);
                    },
                  );
                }),
              )),
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
    Get.toNamed(AppRoutes.AddMeal);
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
            "Add food",
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
