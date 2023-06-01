// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_diet/common/entities/food.dart';

import 'package:my_diet/view/food/foodcontroller.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
            () => DropdownButtonHideUnderline(
              child: DropdownButton(
                elevation: 0,
                iconEnabledColor: AppColors.brand05,
                value: controller.selectedMealTime.isEmpty
                    ? "Breakfast"
                    : controller.selectedMealTime.value,
                items: controller.mealTime
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.onMealTimeChanged(value as String);
                },
                style: const TextStyle(color: AppColors.brand05, fontSize: 16),
              ),
            ),
          ),
          backgroundColor: AppColors.monochromatic09,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0.w),
                        child: const Text(
                          "Amount",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ),
                      Container(
                        height: 70.h,
                        width: 100.w,
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: controller.amountFormKey,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Can\' not be empty';
                              } else if (int.parse(value) <= 0) {
                                return 'Have to be greater than 0';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              if (controller.amountFormKey.currentState!
                                  .validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            controller: controller.amountInputController,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: AppColors.brand05),
                                  borderRadius:
                                      BorderRadius.circular(20.0) //<-- SEE HERE
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0.w),
                          child: const Text(
                            "Unit",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ),
                        SizedBox(
                          //width: 150.w,
                          height: 70.h,
                          child: Center(
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  elevation: 0,
                                  iconEnabledColor: AppColors.brand05,
                                  value: controller.selectedUnit.isEmpty
                                      ? "gram"
                                      : controller.selectedUnit.value,
                                  items: controller.unit
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    controller.onUnitChanged(value as String);
                                  },
                                  style: const TextStyle(
                                      color: AppColors.brand05, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0.w),
                        child: const Text(
                          "Food",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ),
                      Container(
                        width: 150.w,
                        height: 70.h,
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: controller.nameFormKey,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            onEditingComplete: () {
                              if (controller.nameFormKey.currentState!
                                  .validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Can\' not be empty';
                              }
                              return null;
                            },
                            controller: controller.foodInputController,
                            decoration: InputDecoration(
                              //hintText: "Input the foods",
                              alignLabelWithHint: true,
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: AppColors.brand05),
                                  borderRadius:
                                      BorderRadius.circular(20.0) //<-- SEE HERE
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(""),
                      SizedBox(
                        height: 70.0.h,
                        child: IconButton(
                            onPressed: () {
                              if (controller.amountFormKey.currentState!
                                      .validate() &&
                                  controller.nameFormKey.currentState!
                                      .validate()) {
                                controller.getResultFromShortcut();
                                controller.foodInputController.clear();
                                controller.amountInputController.clear();
                              } else {
                                Get.snackbar(
                                  "Failed",
                                  "Please input corrected value",
                                  icon: const Icon(Icons.warning,
                                      color: Colors.red),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                              //controller.getTotalCalories();
                            },
                            icon: const Icon(
                              Icons.add_box_outlined,
                              size: 32.0,
                              color: AppColors.brand05,
                            )),
                      ),
                    ],
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: BoxDecoration(
                            color: AppColors.fontMid,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.question_mark,
                          size: 16.0,
                          color: AppColors.white,
                        )),
                  ),
                  const Expanded(
                    child: Text(
                      "E.g. 2 bowl white rice, 200 gram baked chicken, 2 eggs, 1 bowl salad, 10 gram mayonnaise",
                      style: TextStyle(
                          color: AppColors.fontMid,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),

              // _tabBar(),

              // _tabBarView(),
              Expanded(
                  child: Container(
                color: AppColors.white,
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.startLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    itemCount: controller.foodList.length,
                    itemBuilder: (context, index) {
                      //var string = controller.foodList[index].name.toString();
                      return Dismissible(
                        key: ValueKey<Food>(controller.foodList[index]),
                        background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: AppColors.white,
                            )),
                        onDismissed: (DismissDirection direction) {
                          controller.foodList.removeAt(index);
                          controller.getTotalCalories();
                        },
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            controller.foodList[index].name.toUpperCase(),
                            style: const TextStyle(
                                fontFamily: "OpenSans",
                                color: AppColors.brand04,
                                fontSize: 30),
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                                style: const TextStyle(fontFamily: "OpenSans"),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "${controller.foodList[index].calories.toString()} calories\n",
                                      style: const TextStyle(
                                        color: AppColors.brand05,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  TextSpan(
                                      text:
                                          "${controller.foodList[index].servingSizeG.toString()} gram",
                                      style: const TextStyle(
                                        color: AppColors.brand05,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ]),
                          ),
                          trailing: Wrap(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${controller.foodList[index].carbohydratesTotalG.toStringAsFixed(1)} carbs",
                                  style: const TextStyle(
                                      color: AppColors.fontMid,
                                      fontFamily: "OpenSans"),
                                ),
                                Text(
                                  "${controller.foodList[index].proteinG.toStringAsFixed(1)} pros",
                                  style: const TextStyle(
                                      color: AppColors.fontMid,
                                      fontFamily: "OpenSans"),
                                ),
                                Text(
                                  "${controller.foodList[index].fatTotalG.toStringAsFixed(1)} fats",
                                  style: const TextStyle(
                                      color: AppColors.fontMid,
                                      fontFamily: "OpenSans"),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 10,
                        thickness: 1,
                      );
                    },
                  );

                  // return AlignedGridView.count(
                  //   itemCount: controller.foodList.length,
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 4,
                  //   crossAxisSpacing: 16,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text(
                  //           controller.foodList[index].productName.toString()),
                  //     );
                  //     // FoodTile(controller.foodList[index]);
                  //   },
                  // );
                }),
              )),
              Obx(() {
                return Container(
                  height: 150.h,
                  padding: EdgeInsets.all(10.0.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircularPercentIndicator(
                            animation: true,
                            //backgroundColor: AppColors.fontLight,
                            percent: controller.totalCalories.value / 2000,
                            progressColor: AppColors.brand05,
                            animateFromLastPercent: true,
                            lineWidth: 10.0,
                            radius: 45.0.w,
                            center: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: AppColors.brand05,
                                        fontWeight: FontWeight.w600),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: " 0 cals\n",
                                  ),
                                  TextSpan(
                                    text: " remain",
                                  ),
                                ])),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          // RichText(
                          //     text: TextSpan(
                          //         style: const TextStyle(
                          //             fontFamily: "OpenSans",
                          //             fontSize: 18,
                          //             color: AppColors.brand05,
                          //             fontWeight: FontWeight.w600),
                          //         children: <TextSpan>[
                          //       const TextSpan(
                          //         text: "TOTAL: ",
                          //       ),
                          //       TextSpan(
                          //         text:
                          //             "${controller.totalCalories.toStringAsFixed(1)} calories",
                          //       ),
                          //     ])),
                          //Text("TOTAL: ", style: const TextStyle(fontSize: 30, fontFamily: "OpenSan"),),

                          const Expanded(
                            child: SizedBox(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${controller.totalCarbs.toStringAsFixed(1)} carbs",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${controller.totalPros.toStringAsFixed(1)} pros",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${controller.totalFats.toStringAsFixed(1)} fats",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MaterialButton(
                              color: AppColors.brand05,
                              onPressed: () {},
                              child: const Text(
                                "Log food",
                                style: TextStyle(color: AppColors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              }),
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
                  text: "Foods",
                ),
                Tab(
                  text: "Meals",
                ),
                Tab(
                  text: "Receipe",
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
      color: AppColors.white,
      child: Column(
        children: [
          Container(
            color: AppColors.brand10,
            height: 145.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _functionAddFoodItem(leftTitle, leftIcon, leftTap),
                _functionAddFoodItem(rightTitle, rightIcon, rightTap),
              ],
            ),
          ),
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
    return Expanded(
      child: TabBarView(controller: controller.tabController, children: [
        _functionAddFood(
            "Quick add",
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
