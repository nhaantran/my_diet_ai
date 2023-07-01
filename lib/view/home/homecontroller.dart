import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_diet/services/firestore_service.dart';
import '../../common/entities/userhealt.dart';
import '../../common/routes/names.dart';
import '../../common/store/user.dart';
import '../../common/values/colors.dart';
import '../../common/values/goal.dart';

class HomeController extends GetxController {
  static var baseGoal = 0.0.obs;
  static var caloriesFood = 0.0.obs;
  static var caloriesExercise = 0.obs;
  var waterIntake = 0.0.obs;
  var waterNeeded = 1.0.obs;
  var streaks = 0.obs;
  var progress = 0.0.obs;
  static var caloriesRemaining = 0.0.obs;
  var goal = "".obs;
  var weight = "".obs;
  var currentWeight = "";
  var percentIndicator = 0.0.obs;
  var waterNeededString = "".obs;
  var waterIntakeString = "".obs;
  static CustomerData? userHealth;

  HomeController();

  @override
  void onInit() async {
    // TODO: implement onInit
    await asyncLoadAllData();
    setRulerValue();
    streaks.value = await FireStoreSerivce().getStreaksCount();
    super.onInit();
  }

  dynamic beginValue;
  dynamic endValue;
  setRulerValue() {
    if (goal.value == Goal.loseWeight) {
      beginValue = 40;
      endValue = int.parse(weight.value);
    } else if (goal.value == Goal.gainWeight) {
      beginValue = int.parse(weight.value);
      endValue = 200;
    } else {
      beginValue = int.parse(weight.value) - 5;
      endValue = int.parse(weight.value) + 5;
    }
  }

  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  changeWeight(int index) async {
    weight.value = index.toString();
  }

  waterCount() async {
    waterNeeded.value = await FireStoreSerivce().getWaterNeeded(DateTime.now());
    waterNeededString.value = waterNeeded.value > 1000
        ? " / ${(waterNeeded.value / 1000).toStringAsFixed(1)}l"
        : " / ${waterNeeded.value}ml";

    waterIntake.value =
        await FireStoreSerivce().getWaterDrinked(DateTime.now());
    waterIntakeString.value = waterIntake.value > 1000
        ? (waterIntake.value / 1000).toStringAsFixed(1)
        : waterIntake.value.toString();
  }

  caloriesCount() async {
    var caloriesEaten =
        await FireStoreSerivce().getCaloriesEaten(DateTime.now());
    caloriesFood.value = caloriesEaten;

    var caloriesRemain =
        await FireStoreSerivce().getCaloriesRemaining(DateTime.now());
    if (caloriesRemain == 0.0) {
      caloriesRemaining.value = baseGoal.value;
    } else {
      caloriesRemaining.value = caloriesRemain;
    }
  }

  asyncLoadAllData() async {
    final userData = await db.collection("usersHealth").doc(token).get();

    if (userData.exists) {
      userHealth = CustomerData.fromJson(userData.data()!);
      baseGoal.value =
          userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value;
      weight.value = userHealth!.weight;
      currentWeight = userHealth!.weight;
      goal.value = userHealth!.goal;
    }
    await caloriesCount();
    await waterCount();
    // return CustomerData.fromJson(userData.da)
    //String profile = await UserStore.to.getProfile();
    // if (profile.isNotEmpty) {
    // UserLoginResponseEntity userdata =
    //     UserLoginResponseEntity.fromJson(jsonDecode(profile));
    //   user.value = userdata;
    // }
  }

  updateWeight(int newWeight) async {
    userHealth = await FireStoreSerivce().updateWeightUserHealth(newWeight);
    baseGoal.value =
        userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value;
    weight.value = userHealth!.weight;
    goal.value = userHealth!.goal;
  }

  final List<Text> textList = List<Text>.generate(
    40,
    (index) => Text(
      '${(index + 1) * 50} ml',
    ),
  );

  openBottomPicker(BuildContext context) {
    BottomPicker(
      items: textList,
      title: 'Choose amount',
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 5,
      onSubmit: (index) {
        print('${(index + 1) * 50} ml');
        addWater((index + 1) * 50);
        //loadData(index);
      },
      buttonAlignement: MainAxisAlignment.center,
      displayButtonIcon: false,
      buttonText: 'Confirm',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.brand05,
    ).show(context);
  }

  addWater(int amount) async {
    await FireStoreSerivce().addWater(amount);
    waterIntake.value =
        await FireStoreSerivce().getWaterDrinked(DateTime.now());
    waterIntakeString.value = waterIntake.value > 1000
        ? (waterIntake.value / 1000).toStringAsFixed(1)
        : waterIntake.value.toString();
  }

  void signOutGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    print("User Signed Out");
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
