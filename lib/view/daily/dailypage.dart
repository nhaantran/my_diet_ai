import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/common/routes/names.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';
import 'package:my_diet/view/food/foodbinding.dart';
import 'package:my_diet/view/food/foodpage.dart';
import 'package:my_diet/view/home/homecontroller.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../common/values/colors.dart';
import '../common_widgets/ContentRow.dart';

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
          "Add Dialy Screen",
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
                    icon: Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
                      Get.to(FoodPage("Breakfast"), binding: FoodBinding());
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
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.brand06),
                child: ListTile(
                  title: const Text("Dinner",
                      style: TextStyle(
                          fontFamily: "Gothic", fontWeight: FontWeight.bold)),
                  textColor: AppColors.white,
                  subtitle: Text("Reward in the end of day!"),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 36.0),
                    onPressed: () {
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
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
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
          padding: EdgeInsets.all(20.0),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _caloriesColumn(
                    WelcomeController.user!.basalMetabolicRate.hb.calories.value.toInt()
                        .toString(),
                    "Goal"),
                _caloriesColumn("-", ""),
                _caloriesColumn(
                    homeController.caloriesFood.value.toString(), "Food"),
                _caloriesColumn("-", ""),
                _caloriesColumn(
                    homeController.caloriesExercise.value.toString(),
                    "Exercise"),
                _caloriesColumn("=", ""),
                _caloriesColumn(
                    "${WelcomeController.user!.basalMetabolicRate.hb.calories.value.toInt() - homeController.caloriesFood.value}",
                    "Remaining"),
              ]),
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
                icon: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              );
            },
          )),
        ),
      ],
    );
  }

  Widget _dailyMeal(Widget image, String title, String description) {
    return Padding(
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
      DateTime.now().subtract(const Duration(days: 2)),
      width: 65.w,
      height: 80.h,
      daysCount: 7,
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColors.neutral,
      //selectedTextColor: AppColors.fontDark,
      locale: "vi_VN",
      dayTextStyle: TextStyle(fontFamily: "Gothic", fontSize: 14),
    );
  }
}
