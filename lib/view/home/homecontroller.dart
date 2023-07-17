import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_diet/common/widgets/toast.dart';
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
  static var goal = "".obs;
  static var weight = "".obs;
  static var goalWeight = "".obs;
  static var currentGoalWeight = "".obs;
  static var currentWeight = "".obs;
  static var height = "".obs;
  static var currentHeight = "".obs;
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

    var caloriesExercise =
        await FireStoreSerivce().getCaloriesExercise(DateTime.now());
    HomeController.caloriesExercise.value = caloriesExercise;
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
      currentWeight.value = userHealth!.weight;

      goalWeight.value = userHealth!.goalWeight;
      currentGoalWeight.value = userHealth!.goalWeight;

      height.value = userHealth!.height;
      currentHeight.value = userHealth!.height;
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

  static updateWeight(int newWeight) async {
    print("NEW WEIGHT: ${newWeight.toString()}");
    print("CUREENT WEIGHT: ${currentWeight.value}");
    if (newWeight.toString() != currentWeight.value) {
      userHealth = await FireStoreSerivce().updateWeightUserHealth(newWeight);
      baseGoal.value =
          userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value;
      weight.value = userHealth!.weight;
      currentWeight.value = weight.value;
      goal.value = userHealth!.goal;
      await noticeTrack();
    }
  }

  static noticeTrack() async {
    if ((num.tryParse(weight.value)! - num.tryParse(goalWeight.value)!).abs() <
        5) {
      if ((num.tryParse(weight.value)! - num.tryParse(goalWeight.value)!)
              .abs() ==
          0) {
        Get.dialog(AlertDialog(
            title: const Text("Congratulation"),
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Image.asset("assets/images/healthy_lifestyle.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "You have reach your goals!!!",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )));
      } else {
        Get.dialog(AlertDialog(
            title: const Text("Congratulation"),
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Image.asset("assets/images/healthy_lifestyle.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "You nearly reach your goals!!!",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )));
      }
    }
  }

  static updateGoalWeight(int newWeight) async {
    print("NEW WEIGHT: ${newWeight.toString()}");
    print("CUREENT GOAL WEIGHT: ${currentGoalWeight.value}");

    if (newWeight.toString() != currentGoalWeight.value) {
      userHealth =
          await FireStoreSerivce().updateGoalWeightUserHealth(newWeight);
      baseGoal.value =
          userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value;
      goalWeight.value = userHealth!.goalWeight;
      goal.value = userHealth!.goal;
    }
  }

  static updateHeight(int newHeight) async {
    if (newHeight.toString() != currentHeight.value) {
      userHealth = await FireStoreSerivce().updateHeightUserHealth(newHeight);
      baseGoal.value =
          userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value;
      height.value = userHealth!.height;
      goal.value = userHealth!.goal;
    }
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
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 5,
      onSubmit: (index) async {
        await addWater((index + 1) * 50);
        toastInfo(msg: "Add water successful");
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
