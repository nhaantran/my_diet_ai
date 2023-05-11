import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';

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
          const SizedBox(height: 40.0),
          Center(
            child: _datePicker(),
          ),
          const SizedBox(height: 40.0),
          _caloriesRemaining(),
          const SizedBox(height: 20.0),
          ContentRow(
            description: 'this is a test',
            header: 'TEST',
            icon: AssetImage("assets/icons/active.png"),
            onTap: () {},
          ),
          const SizedBox(
            height: 5.0,
          ),
          ContentRow(
            image: "assets/images/bida.jpg",
            description: 'this is a test',
            header: 'TEST',
            icon: AssetImage("assets/icons/active.png"),
            onTap: () {},
          ),
          const SizedBox(
            height: 5.0,
          ),
          ContentRow(
            image: "assets/images/bida.jpg",
            description: 'this is a test',
            header: 'TEST',
            icon: AssetImage("assets/icons/active.png"),
            onTap: () {},
          ),
          const SizedBox(
            height: 5.0,
          ),
          ContentRow(
            image: "assets/images/bida.jpg",
            description: 'this is a test',
            header: 'TEST',
            icon: AssetImage("assets/icons/active.png"),
            onTap: () {},
          ),
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
                _caloriesColumn(homeController.baseGoal.toString(), "Goal"),
                _caloriesColumn("-", ""),
                _caloriesColumn(homeController.caloriesFood.toString(), "Food"),
                _caloriesColumn("-", ""),
                _caloriesColumn(
                    homeController.caloriesExercise.toString(), "Exercise"),
                _caloriesColumn("=", ""),
                _caloriesColumn("Not yet", "Remaining"),
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
                icon: AssetImage("assets/icons/active.png"),
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
      selectionColor: AppColors.success,
      //selectedTextColor: AppColors.fontDark,
      locale: "vi_VN",
      dayTextStyle: TextStyle(fontFamily: "Gothic", fontSize: 14),
    );
  }
}
