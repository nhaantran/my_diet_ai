import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/services/remote_service.dart';

import '../../common/entities/userhealt.dart';

class FoodController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  List<String> mealTime = <String>["Breakfast", "Lunch", "Dinner", "Snack"];
  final selectedMealTime = "Breakfast".obs;

  // FoodController() {
  //   selectedMealTime = mealTime.first.obs;
  // }
  @override
  void onInit() {
    super.onInit();
    
    //getData();
    tabController = TabController(length: 4, vsync: this);
  }

  void onMealTimeChanged(String value) {
    selectedMealTime.value = value;
  }

  getData() async {
    List<String>? list = await RemoteService().getFoods();
    //CustomerData? example = await RemoteService().postHealthInformation();
  }
}
