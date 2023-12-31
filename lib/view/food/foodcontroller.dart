import 'dart:io';
import 'dart:developer';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_diet/common/entities/food.dart';
import 'package:image/image.dart' as img;
import 'package:my_diet/common/entities/untracked.dart';
import 'package:my_diet/common/values/foodsName.dart';
import 'package:my_diet/helpers/image_classification_helper.dart';
import 'package:my_diet/services/firestore_service.dart';
import 'package:my_diet/services/remote_service.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../common/values/colors.dart';

class FoodController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  var isLoading = true.obs;
  var startLoading = false.obs;
  List<String> mealTime = <String>["Breakfast", "Lunch", "Dinner", "Snack"];
  List<String> unit = <String>["gram", "lbs", "bowl", "none"];
  static final selectedUnit = "gram".obs;
  static final selectedMealTime = "Breakfast".obs;

  final TextEditingController foodInputController = TextEditingController();
  final TextEditingController amountInputController = TextEditingController();
  final TextEditingController untrackedInputController =
      TextEditingController();
  ImageClassificationHelper? imageClassificationHelper;
  final amountFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final untrackedFormKey = GlobalKey<FormState>();
  var remainingCalories = 0.0.obs;
  var foodCalories = 0.0.obs;
  var exerciseCalories = 0.0.obs;
  var baseGoal = 0.0.obs;
  DateTime selectedDate = DateTime.now();
  var totalCalories = 0.0.obs;
  var totalCarbs = 0.0.obs;
  var totalPros = 0.0.obs;
  var totalFats = 0.0.obs;
  static var foodList = <Food>[].obs;
  var productList = <Product>[].obs;
  var productQuery = "".obs;
  var imagePath = "".obs;
  img.Image? image;
  Map<String, double>? classification;
  var percent = 0.0.obs;
  // FoodController() {
  //   selectedMealTime = mealTime.first.obs;
  // }
  static var initialIndex = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    imageClassificationHelper = ImageClassificationHelper();
    //getData();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: initialIndex.value);
    await getCalories(DailyController.selectedDate);
    await imageClassificationHelper!.initHelper();
  }

  void onMealTimeChanged(String value) {
    selectedMealTime.value = value;
  }

  static addFood(Food addedFood) {
    foodList.add(addedFood);
  }

  void onUnitChanged(String value) {
    selectedUnit.value = value;
  }

  logfood() async {
    await FireStoreSerivce().addMeal(selectedMealTime.value, foodList);
    DailyController().getListOfDialy();
    DailyController().getCalories(DateTime.now());
    await HomeController().caloriesCount();
    foodList.clear();
    getSnackBar();
  }

  getResultFromShortcut() async {
    isLoading(true);
    startLoading(true);
    try {
      var input =
          "${amountInputController.text} ${selectedUnit.toString() == "none" ? '' : selectedUnit.toString()} ${foodInputController.text}";
      log("Input: $input");
      var foods = await RemoteService().getFoodsFromShortcut(input);

      if (foods != null) {
        if (foodList.isEmpty) {
          foodList.value = foods;
        } else {
          for (int index = 0; index < foods.length; index++) {
            foodList.add(foods[index]);
          }
        }
      } else {
        log("food = null");
      }
    } finally {
      isLoading(false);
      startLoading(false);
      getTotalCalories();
    }
  }

  getResultFromFinding(String query) async {
    isLoading(true);
    startLoading(true);
    try {
      productQuery.value = query;
      var foods = await RemoteService().getFoodfromFinding(query);

      if (foods != null) {
        productList.value = foods;
      }
    } finally {
      isLoading(false);
      startLoading(false);
      getTotalCalories();
    }
  }

  getResultFromImagePicker() async {
    isLoading(true);
    startLoading(true);
    try {
      var food = await FireStoreSerivce().getFood(productQuery.value);
      if (food != null) {
        if (foodList.isEmpty) {
          var listOfFoods = <Food>[food];
          foodList.value = listOfFoods;
        } else {
          foodList.add(food);
        }
      } else {
        log("food = null");
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

    percent.value =
        (foodCalories.value + totalCalories.value - exerciseCalories.value) /
            baseGoal.value;
    remainingCalories.value = baseGoal.value -
        (foodCalories.value + totalCalories.value - exerciseCalories.value);
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
          baseGoal.value - foodCalories.value + this.exerciseCalories.value;
    } else {
      baseGoal.value = foodCalories.value +
          remainingCalories.value -
          this.exerciseCalories.value;
    }
    getTotalCalories();
    // exercise here
  }

  final List<Text> textList = List<Text>.generate(
    200,
    (index) => Text(
      '${(index) * 50} calories',
    ),
  );

  openBottomPicker(BuildContext context) {
    BottomPicker(
      items: textList,
      title: 'Estimate calories of the food or just leave it 0',
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 0,
      onSubmit: (index) {
        logUntrackedCalories(double.parse((index * 50).toString()));
      },
      buttonAlignement: MainAxisAlignment.center,
      displayButtonIcon: false,
      buttonText: 'Confirm',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.brand05,
    ).show(context);
  }

  logUntrackedCalories(double calories) async {
    var untrackedFoodCalories = {
      "description": untrackedInputController.text,
      "calories": calories
    };
    untrackedInputController.clear();
    var addedUntrackedFood = UntrackedFood.fromJson(untrackedFoodCalories);
    await FireStoreSerivce().addUntrackedFoodCalories(addedUntrackedFood);
    DailyController().getCalories(DateTime.now());
    DailyController().getListOfDialy();
    await HomeController().caloriesCount();
    getSnackBar();
  }

  getSnackBar() {
    Get.snackbar(
      'Log food success',
      'You can check your calories in Daily Journey sceen',
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
    );
  }

  getData() {
    return foodInputController.text;
  }

  Future pickImageFromGallery() async {
    var returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      final imageData = File(returnedImage.path).readAsBytesSync();
      image = img.decodeImage(imageData);
      //List Key-> MON AN, value-> TY LE
      classification = await imageClassificationHelper?.inferenceImage(image!);
      double minDouble = double.negativeInfinity;
      classification!.forEach((key, value) {
        if (value > minDouble) {
          minDouble = value;
          productQuery.value = key.toString();
        }
      });
    }
  }
}
