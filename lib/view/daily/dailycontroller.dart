import 'package:get/get.dart';
import 'package:my_diet/services/firestore_service.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import '../../common/entities/exercise.dart';
import '../../common/entities/food.dart';
import '../../common/entities/untracked.dart';
import '../../common/widgets/toast.dart';

class DailyController extends GetxController {
  var isLoading = true.obs;
  var startLoading = false.obs;
  static var foodListBreakfast = <Food>[].obs;
  static var foodListLunch = <Food>[].obs;
  static var foodListDinner = <Food>[].obs;
  static var foodListSnack = <Food>[].obs;
  static var exerciseList = <Exercise>[].obs;
  static var untrackedFoodList = <UntrackedFood>[].obs;
  static var untrackedExerciseList = <UntrackedExercise>[].obs;

  static var remainingCalories = 0.0.obs;
  static var foodCalories = 0.0.obs;
  static var exerciseCalories = 0.0.obs;
  static var baseGoal = 0.0.obs;
  static DateTime selectedDate = DateTime.now();
  DailyController();

  @override
  void onInit() async {
    await getCalories(selectedDate);
    await getListOfDialy();
    super.onInit();
  }

  clearList() {
    foodListBreakfast.clear();
    foodListLunch.clear();
    foodListDinner.clear();
    foodListSnack.clear();
    exerciseList.clear();
    untrackedFoodList.clear();
    untrackedExerciseList.clear();
  }

  onDateChange(DateTime date) {
    selectedDate = date;
    clearList();
    getListOfDialy();
    getCalories(selectedDate);
  }

  getCalories(DateTime date) async {
    foodCalories.value = await FireStoreSerivce().getCaloriesEaten(date);

    remainingCalories.value =
        await FireStoreSerivce().getCaloriesRemaining(date);
    int exerciseCalories = await FireStoreSerivce().getCaloriesExercise(date);
    DailyController.exerciseCalories.value = exerciseCalories.toDouble();
    if (foodCalories.value == 0.0 || remainingCalories.value == 0.0) {
      baseGoal.value = HomeController.baseGoal.value;
      remainingCalories.value = baseGoal.value -
          foodCalories.value +
          DailyController.exerciseCalories.value;
    } else {
      baseGoal.value = foodCalories.value +
          remainingCalories.value -
          DailyController.exerciseCalories.value;
    }
    // exercise here
  }

  getListOfDialy() async {
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
      var exerciseList =
          await FireStoreSerivce().getListOfExercise(selectedDate);
      var untrackedFoodList =
          await FireStoreSerivce().getListOfUntrackedFood(selectedDate);
      var untrackedExerciseList =
          await FireStoreSerivce().getListOfUntrackedExercise(selectedDate);
      foodListBreakfast.value = breakfastFoodsList!;
      foodListLunch.value = lunchFoodsList!;
      foodListDinner.value = dinnerFoodsList!;
      foodListSnack.value = snackFoodsList!;
      DailyController.exerciseList.value = exerciseList!;
      DailyController.untrackedFoodList.value = untrackedFoodList!;
      DailyController.untrackedExerciseList.value = untrackedExerciseList!;
    } finally {
      isLoading.value = false;
      startLoading.value = false;
    }
  }

  informFailMessage() {
    toastInfo(msg: "Failed task");
  }

  informSuccessMessage() {
    toastInfo(msg: "Successful task");
  }

  deleteFood(Food deletedFood, String session) async {
    await FireStoreSerivce().deleteFood(deletedFood, session);
    informSuccessMessage();
    HomeController().caloriesCount();
  }

  deleteUntrackedFood(UntrackedFood deletedFood) async {
    await FireStoreSerivce().deleteUntrackedFood(deletedFood);
    informSuccessMessage();
    HomeController().caloriesCount();
  }

  deleteUntrackedExercise(UntrackedExercise deletedExercise) async {
    await FireStoreSerivce().deleteUntrackedExercise(deletedExercise);
    informSuccessMessage();
    HomeController().caloriesCount();
  }

  deleteExercise(Exercise deletedExercise) async {
    await FireStoreSerivce().deleteExercise(deletedExercise);
    informSuccessMessage();
    HomeController().caloriesCount();
  }
}
