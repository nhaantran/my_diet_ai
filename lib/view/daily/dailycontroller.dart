import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/services/firestore_service.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import '../../common/entities/food.dart';
import '../../common/widgets/toast.dart';

class DailyController extends GetxController {
  var isLoading = true.obs;
  var startLoading = false.obs;
  static var foodListBreakfast = <Food>[].obs;
  static var foodListLunch = <Food>[].obs;
  static var foodListDinner = <Food>[].obs;
  static var foodListSnack = <Food>[].obs;

  var remainingCalories = 0.0.obs;
  var foodCalories = 0.0.obs;
  var exerciseCalories = 0.0.obs;
  var baseGoal = 0.0.obs;
  DateTime selectedDate = DateTime.now();
  DailyController();

  @override
  void onInit() async {
    await getCalories(selectedDate);
    await getListOfFood();
    super.onInit();
  }

  onDateChange(DateTime date) {
    selectedDate = date;

    foodListBreakfast.clear();
    foodListLunch.clear();
    foodListDinner.clear();
    foodListSnack.clear();

    getListOfFood();
    getCalories(selectedDate);
  }

  
  getCalories(DateTime date) async {
    foodCalories.value = await FireStoreSerivce().getCaloriesEaten(date);

    remainingCalories.value =
        await FireStoreSerivce().getCaloriesRemaining(date);
    int exerciseCalories = await FireStoreSerivce().getCaloriesExercise(date);
    this.exerciseCalories.value = exerciseCalories.toDouble();
    if (foodCalories.value == 0.0 || remainingCalories.value == 0.0) {
      baseGoal.value = HomeController.baseGoal.value;
      remainingCalories.value =
          baseGoal.value - foodCalories.value - this.exerciseCalories.value;
    } else {
      baseGoal.value = foodCalories.value +
          remainingCalories.value +
          this.exerciseCalories.value;
    }
    // exercise here
  }

  getListOfFood() async {
    isLoading.value = true;
    startLoading.value = true;
    try {
      var breakfastFoodsList =
          await FireStoreSerivce().getListOfFood(selectedDate, "Breakfast");
      var lunchFoodsList =
          await FireStoreSerivce().getListOfFood(selectedDate, "Lunch");
      var dinnerFoodsList =
          await FireStoreSerivce().getListOfFood(selectedDate, "Dinner");
      var snackFoodsList =
          await FireStoreSerivce().getListOfFood(selectedDate, "Snack");

      foodListBreakfast.value = breakfastFoodsList!;
      foodListLunch.value = lunchFoodsList!;
      foodListDinner.value = dinnerFoodsList!;
      foodListSnack.value = snackFoodsList!;
    } finally {
      isLoading.value = false;
      startLoading.value = false;
    }
  }

  failAddFood() {
    toastInfo(msg: "Login Success");
  }

  deleteFoodBreakfast(Food deletedFood) async {
    await FireStoreSerivce().deleteFood(deletedFood, "Breakfast");
    HomeController().caloriesCount();
  }
}
