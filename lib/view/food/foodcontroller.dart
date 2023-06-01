import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/common/entities/food.dart';
import 'package:my_diet/services/remote_service.dart';

class FoodController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  var isLoading = true.obs;
  var startLoading = false.obs;
  List<String> mealTime = <String>["Breakfast", "Lunch", "Dinner", "Snack"];
  List<String> unit = <String>["gram", "lbs", "bowl", "none"];
  final selectedUnit = "gram".obs;
  final selectedMealTime = "Breakfast".obs;
  final TextEditingController foodInputController = TextEditingController();
  final TextEditingController amountInputController = TextEditingController();
  final amountFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  
  var totalCalories = 0.0.obs;
  var totalCarbs = 0.0.obs;
  var totalPros = 0.0.obs;
  var totalFats = 0.0.obs;
  var foodList = <Food>[].obs;
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

  void onUnitChanged(String value) {
    selectedUnit.value = value;
  }

  getResultFromShortcut() async {
    isLoading(true);
    startLoading(true);
    try {
      var input =
          "${amountInputController.text} ${selectedUnit.toString() == "none" ? '' : selectedUnit.toString()} ${foodInputController.text}";

      var foods = await RemoteService().getFoods(input);
      if (foods != null) {
        if (foodList.isEmpty) {
          foodList.value = foods;
        } else {
          for (int index = 0; index < foods.length; index++) {
            foodList.add(foods[index]);
          }
        }
      }
    } finally {
      isLoading(false);
      startLoading(false);
      getTotalCalories();
    }
  }

  getTotalCalories() {
    totalCalories.value = 0.0;
    totalCarbs = 0.0.obs;
    totalPros = 0.0.obs;
    totalFats = 0.0.obs;
    for (int i = 0; i < foodList.length; i++) {
      totalCalories.value += foodList[i].calories;
      totalCarbs.value += foodList[i].carbohydratesTotalG;
      totalPros.value += foodList[i].proteinG;
      totalFats.value += foodList[i].fatTotalG;
    }
  }

  getData() {
    return foodInputController.text;
  }
}
