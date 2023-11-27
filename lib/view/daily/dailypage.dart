import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/common/entities/exercise.dart';
import 'package:my_diet/common/entities/untracked.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';
import 'package:my_diet/view/food/foodbinding.dart';
import 'package:my_diet/view/food/foodpage.dart';
import 'package:my_diet/view/home/homecontroller.dart';
import '../../common/entities/food.dart';
import '../../common/values/colors.dart';
import '../common_widgets/ContentRow.dart';
import '../exercise/exercisebinding.dart';
import '../exercise/exercisepage.dart';
import '../food/foodcontroller.dart';

class DailyPage extends GetView<DailyController> {
  const DailyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.monochromatic09,
      // color: AppColors.monochromatic09,
      // alignment: Alignment.topCenter,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.monochromatic09,
        title: const Text(
          "Dialy Journey",
          style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.brand05),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 20.0),
          Center(
            child: _datePicker(),
          ),
          const SizedBox(height: 10.0),
          _caloriesRemaining(),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.brand06),
                child: ListTile(
                  title: const Text("Breakfast",
                      style: TextStyle(
                          fontFamily: "Gothic", fontWeight: FontWeight.bold)),
                  textColor: AppColors.white,
                  subtitle: Text("Engery for the day!"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
                      FoodController.initialIndex.value = 0;

                      Get.to(() => FoodPage("Breakfast"),
                          binding: FoodBinding());
                    },
                  ),
                  tileColor: AppColors.brand05,
                  iconColor: AppColors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("assets/icons/breakfast.png",
                        fit: BoxFit.fill),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.startLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DailyController.foodListBreakfast.length,
                  itemBuilder: (context, index) {
                    //var string = controller.foodList[index].name.toString();
                    return Dismissible(
                      key: ValueKey<Food>(
                          DailyController.foodListBreakfast[index]),
                      background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      onDismissed: (DismissDirection direction) {
                        // method
                        controller.deleteFood(
                            DailyController.foodListBreakfast[index],
                            "Breakfast");
                        DailyController.foodListBreakfast.removeAt(index);
                      },
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          DailyController.foodListBreakfast[index].name
                              .toUpperCase(),
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
                                        "${DailyController.foodListBreakfast[index].calories.toString()} calories\n",
                                    style: const TextStyle(
                                      color: AppColors.brand05,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                        "${DailyController.foodListBreakfast[index].servingSizeG.toString()} gram",
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
                                "${DailyController.foodListBreakfast[index].carbohydratesTotalG.toStringAsFixed(1)} carbs",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListBreakfast[index].proteinG.toStringAsFixed(1)} pros",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListBreakfast[index].fatTotalG.toStringAsFixed(1)} fats",
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
              }),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.brand06),
                child: ListTile(
                  title: const Text("Lunch",
                      style: TextStyle(
                          fontFamily: "Gothic", fontWeight: FontWeight.bold)),
                  textColor: AppColors.white,
                  subtitle: Text("Fuel for the rest!"),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
                      FoodController.initialIndex.value = 0;

                      Get.to(FoodPage("Lunch"), binding: FoodBinding());
                    },
                  ),
                  tileColor: AppColors.brand05,
                  iconColor: AppColors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        Image.asset("assets/icons/lunch.png", fit: BoxFit.fill),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.startLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DailyController.foodListLunch.length,
                  itemBuilder: (context, index) {
                    //var string = controller.foodList[index].name.toString();
                    return Dismissible(
                      key: ValueKey<Food>(DailyController.foodListLunch[index]),
                      background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      onDismissed: (DismissDirection direction) {
                        // method
                        controller.deleteFood(
                            DailyController.foodListLunch[index], "Lunch");
                        DailyController.foodListLunch.removeAt(index);
                      },
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          DailyController.foodListLunch[index].name
                              .toUpperCase(),
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
                                        "${DailyController.foodListLunch[index].calories.toString()} calories\n",
                                    style: const TextStyle(
                                      color: AppColors.brand05,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                        "${DailyController.foodListLunch[index].servingSizeG.toString()} gram",
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
                                "${DailyController.foodListLunch[index].carbohydratesTotalG.toStringAsFixed(1)} carbs",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListLunch[index].proteinG.toStringAsFixed(1)} pros",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListLunch[index].fatTotalG.toStringAsFixed(1)} fats",
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
              }),
              Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: AppColors.brand06),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Dinner",
                            style: TextStyle(
                                fontFamily: "Gothic",
                                fontWeight: FontWeight.bold)),
                        textColor: AppColors.white,
                        subtitle: Text("Reward in the end of day!"),
                        trailing: IconButton(
                          icon: Icon(Icons.add_circle_outline, size: 36.0),
                          onPressed: () {
                            FoodController.initialIndex.value = 0;
                            Get.to(FoodPage("Dinner"), binding: FoodBinding());
                          },
                        ),
                        tileColor: AppColors.brand05,
                        iconColor: AppColors.white,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset("assets/icons/dinner.png",
                              fit: BoxFit.fill),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      // ListView.builder(
                      //     itemCount: 1,
                      //     itemBuilder: ((context, index) {
                      //       return Container();
                      //     }))
                    ],
                  )),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.startLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DailyController.foodListDinner.length,
                  itemBuilder: (context, index) {
                    //var string = controller.foodList[index].name.toString();
                    return Dismissible(
                      key:
                          ValueKey<Food>(DailyController.foodListDinner[index]),
                      background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      onDismissed: (DismissDirection direction) {
                        // method
                        controller.deleteFood(
                            DailyController.foodListDinner[index], "Dinner");
                        DailyController.foodListDinner.removeAt(index);
                      },
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          DailyController.foodListDinner[index].name
                              .toUpperCase(),
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
                                        "${DailyController.foodListDinner[index].calories.toString()} calories\n",
                                    style: const TextStyle(
                                      color: AppColors.brand05,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                        "${DailyController.foodListDinner[index].servingSizeG.toString()} gram",
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
                                "${DailyController.foodListDinner[index].carbohydratesTotalG.toStringAsFixed(1)} carbs",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListDinner[index].proteinG.toStringAsFixed(1)} pros",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListDinner[index].fatTotalG.toStringAsFixed(1)} fats",
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
              }),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.brand06),
                child: ListTile(
                  title: const Text("Snack",
                      style: TextStyle(
                          fontFamily: "Gothic", fontWeight: FontWeight.bold)),
                  textColor: AppColors.white,
                  subtitle: Text("Little bit free time?"),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
                      FoodController.initialIndex.value = 0;
                      Get.to(FoodPage("Snack"), binding: FoodBinding());
                    },
                  ),
                  tileColor: AppColors.brand05,
                  iconColor: AppColors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        Image.asset("assets/icons/snack.png", fit: BoxFit.fill),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.startLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DailyController.foodListSnack.length,
                  itemBuilder: (context, index) {
                    //var string = controller.foodList[index].name.toString();
                    return Dismissible(
                      key: ValueKey<Food>(DailyController.foodListSnack[index]),
                      background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      onDismissed: (DismissDirection direction) {
                        // method
                        controller.deleteFood(
                            DailyController.foodListSnack[index], "Snack");
                        DailyController.foodListSnack.removeAt(index);
                      },
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          DailyController.foodListSnack[index].name
                              .toUpperCase(),
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
                                        "${DailyController.foodListSnack[index].calories.toString()} calories\n",
                                    style: const TextStyle(
                                      color: AppColors.brand05,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                        "${DailyController.foodListSnack[index].servingSizeG.toString()} gram",
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
                                "${DailyController.foodListSnack[index].carbohydratesTotalG.toStringAsFixed(1)} carbs",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListSnack[index].proteinG.toStringAsFixed(1)} pros",
                                style: const TextStyle(
                                    color: AppColors.fontMid,
                                    fontFamily: "OpenSans"),
                              ),
                              Text(
                                "${DailyController.foodListSnack[index].fatTotalG.toStringAsFixed(1)} fats",
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
              }),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.brand06),
                child: ListTile(
                  title: const Text("Exercise",
                      style: TextStyle(
                          fontFamily: "Gothic", fontWeight: FontWeight.bold)),
                  textColor: AppColors.white,
                  subtitle: const Text("Moving around a little bit?"),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
                      Get.to(() => ExercisePage(), binding: ExerciseBinding());
                    },
                  ),
                  tileColor: AppColors.brand05,
                  iconColor: AppColors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("assets/icons/exercise.png",
                        fit: BoxFit.fill),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.startLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DailyController.exerciseList.length,
                  itemBuilder: (context, index) {
                    //var string = controller.foodList[index].name.toString();
                    return Dismissible(
                      key: ValueKey<Exercise>(
                          DailyController.exerciseList[index]),
                      background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      onDismissed: (DismissDirection direction) {
                        // method
                        controller.deleteExercise(
                            DailyController.exerciseList[index]);
                        DailyController.exerciseList.removeAt(index);
                      },
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          DailyController.exerciseList[index].name
                              .toUpperCase(),
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
                                        "${DailyController.exerciseList[index].totalCalories.toString()} calories\n",
                                    style: const TextStyle(
                                      color: AppColors.brand05,
                                      fontWeight: FontWeight.w600,
                                    )),
                                TextSpan(
                                    text:
                                        "${DailyController.exerciseList[index].durationMinutes.toString()} min",
                                    style: const TextStyle(
                                      color: AppColors.brand05,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ]),
                        ),
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
              }),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.brand06),
                child: ListTile(
                  title: const Text("Untracked Calories",
                      style: TextStyle(
                          fontFamily: "Gothic", fontWeight: FontWeight.bold)),
                  textColor: AppColors.white,
                  subtitle: const Text("It is not easy right?"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
                      FoodController.initialIndex.value = 2;
                      Get.to(FoodPage("Snack"), binding: FoodBinding());
                    },
                  ),
                  tileColor: AppColors.brand05,
                  iconColor: AppColors.white,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("assets/icons/untracked.png",
                        fit: BoxFit.fill),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value &&
                    controller.startLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: DailyController.untrackedFoodList.length,
                      itemBuilder: (context, index) {
                        //var string = controller.foodList[index].name.toString();
                        return Dismissible(
                          key: ValueKey<UntrackedFood>(
                              DailyController.untrackedFoodList[index]),
                          background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.white,
                              )),
                          onDismissed: (DismissDirection direction) {
                            // method
                            controller.deleteUntrackedFood(
                                DailyController.untrackedFoodList[index]);
                            DailyController.untrackedFoodList.removeAt(index);
                          },
                          child: ListTile(
                            // isThreeLine: true,
                            title: Text(
                              DailyController
                                  .untrackedFoodList[index].description
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  color: AppColors.brand04,
                                  fontSize: 30),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                  style:
                                      const TextStyle(fontFamily: "OpenSans"),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            "${DailyController.untrackedFoodList[index].calories.toString()} calories\n",
                                        style: const TextStyle(
                                          color: AppColors.brand05,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    // TextSpan(
                                    //     text:
                                    //         "${DailyController.foodListSnack[index].servingSizeG.toString()} gram",
                                    //     style: const TextStyle(
                                    //       color: AppColors.brand05,
                                    //       fontWeight: FontWeight.w500,
                                    //     )),
                                  ]),
                            ),
                            // trailing: Wrap(children: [
                            //   Column(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Text(
                            //         "${DailyController.foodListSnack[index].carbohydratesTotalG.toStringAsFixed(1)} carbs",
                            //         style: const TextStyle(
                            //             color: AppColors.fontMid,
                            //             fontFamily: "OpenSans"),
                            //       ),
                            //       Text(
                            //         "${DailyController.foodListSnack[index].proteinG.toStringAsFixed(1)} pros",
                            //         style: const TextStyle(
                            //             color: AppColors.fontMid,
                            //             fontFamily: "OpenSans"),
                            //       ),
                            //       Text(
                            //         "${DailyController.foodListSnack[index].fatTotalG.toStringAsFixed(1)} fats",
                            //         style: const TextStyle(
                            //             color: AppColors.fontMid,
                            //             fontFamily: "OpenSans"),
                            //       ),
                            //     ],
                            //   ),
                            // ]),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 10,
                          thickness: 1,
                        );
                      },
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2.0,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: DailyController.untrackedExerciseList.length,
                      itemBuilder: (context, index) {
                        //var string = controller.foodList[index].name.toString();
                        return Dismissible(
                          key: ValueKey<UntrackedExercise>(
                              DailyController.untrackedExerciseList[index]),
                          background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.white,
                              )),
                          onDismissed: (DismissDirection direction) {
                            // method
                            controller.deleteUntrackedExercise(
                                DailyController.untrackedExerciseList[index]);
                            DailyController.untrackedExerciseList
                                .removeAt(index);
                          },
                          child: ListTile(
                            // isThreeLine: true,
                            title: Text(
                              DailyController
                                  .untrackedExerciseList[index].description
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  color: AppColors.brand04,
                                  fontSize: 30),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                  style:
                                      const TextStyle(fontFamily: "OpenSans"),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            "${DailyController.untrackedExerciseList[index].calories.toString()} calories\n",
                                        style: const TextStyle(
                                          color: AppColors.brand05,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    TextSpan(
                                        text:
                                            "${DailyController.untrackedExerciseList[index].duration.toString()} min",
                                        style: const TextStyle(
                                          color: AppColors.brand05,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ]),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 10,
                          thickness: 1,
                        );
                      },
                    ),
                  ],
                );
              }),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _caloriesRemaining() {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Calories Remaining",
                style: TextStyle(fontFamily: "OpenSans", fontSize: 16),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _caloriesColumn(
                          DailyController.baseGoal.value.toStringAsFixed(1),
                          // WelcomeController.user!.basalMetabolicRate.hb.calories.value.toInt()
                          //     .toString(),
                          "Goal"),
                      _caloriesColumn("-", ""),
                      _caloriesColumn(
                          DailyController.foodCalories.value.toStringAsFixed(1),
                          "Food"),
                      _caloriesColumn("+", ""),
                      _caloriesColumn(
                          DailyController.exerciseCalories.value
                              .toStringAsFixed(1),
                          "Exercise"),
                      _caloriesColumn("=", ""),
                      _caloriesColumn(
                          //"${WelcomeController.user!.basalMetabolicRate.hb.calories.value.toInt() - homeController.caloriesFood.value}",
                          DailyController.remainingCalories.value
                              .toStringAsFixed(1),
                          "Remaining"),
                    ]),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _dailyMealListView() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
          sliver: SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ContentRow(
                description: 'this is a test',
                header: 'TEST',
                icon: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              );
            },
          )),
        ),
      ],
    );
  }

  Widget _dailyMeal(Widget image, String title, String description) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }

  Widget _caloriesColumn(String content, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          content,
          style: const TextStyle(
              fontFamily: "OpenSans",
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: "OpenSans",
              fontSize: 12,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _datePicker() {
    return DatePicker(
      DateTime.now().subtract(const Duration(days: 4)),
      width: 65.w,
      height: 80.h,
      daysCount: 9,
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColors.neutral,
      //selectedTextColor: AppColors.fontDark,
      onDateChange: (selectedDate) {
        controller.onDateChange(selectedDate);
      },
      locale: "en_US",
      dayTextStyle: TextStyle(fontFamily: "Gothic", fontSize: 14),
    );
  }
}
