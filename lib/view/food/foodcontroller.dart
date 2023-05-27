import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/services/remote_service.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../common/entities/userhealt.dart';

class FoodController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  var isLoading = true.obs;
  var startLoading = false.obs;
  List<String> mealTime = <String>["Breakfast", "Lunch", "Dinner", "Snack"];
  final selectedMealTime = "Breakfast".obs;
  final TextEditingController foodSearchController = TextEditingController();

  var foodList = <Product>[].obs;
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
    isLoading(true);
    startLoading(true);
    try {
      var foods = await RemoteService().getFood(foodSearchController.text);
      if (foods != null) {
        foodList.value = foods;
      }
    } finally {
      // for (int i = 0; i < foodList.length; i++) {
      //   print("Name: +${foodList.value[i].productName}");
      // }
      isLoading(false);
      startLoading(false);
    }
  }
}
