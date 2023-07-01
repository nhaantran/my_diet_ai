import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_diet/services/firestore_service.dart';

import '../../common/entities/userhealt.dart';
import '../../common/routes/names.dart';
import '../../common/values/goal.dart';
import '../../common/values/exercise.dart';

import '../../services/remote_service.dart';

class WelcomeController extends GetxController {
  var name = "nhaantran".obs;
  var age = 21.obs;
  var index = 0.obs;
  var gender = "male".obs;
  var goal = Goal.maintenance.obs;
  var exercise = Exercise.moderate.obs;
  var progressValue = 0.0.obs;
  var height = 170.obs;
  var goalWeight = 80.obs;
  var weight = 75.obs;
  dynamic beginValue;
  dynamic endValue;
  final TextEditingController ageInputController = TextEditingController();

  static CustomerData? user;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  setRulerValue() {
    if (goal.value == Goal.loseWeight) {
      beginValue = 40;
      endValue = weight.value;
    } else if (goal.value == Goal.gainWeight) {
      beginValue = weight.value;
      endValue = 200;
    } else {
      beginValue = weight.value - 5;
      endValue = weight.value + 5;
    }
  }

  changePage(int index) async {
    this.index.value = index;
    progressValue.value = index / 10;
  }

  changeWeight(int index) async {
    weight.value = index;
    setRulerValue();
  }

  changeGoalWeight(int index) async {
    weight.value = index;
  }

  changeHeight(int value) async {
    height.value = value;
  }

  movingNextPage(PageController pageController, int currentPageIndex) {
    //final controller = Get.find<ButtonController>();
    //controller.onTap();
    pageController.animateToPage(
      currentPageIndex + 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  handleSignIn() async {
    //ConfigStore.to.saveAlreadyOpen();
    await getData();
    //RemoteService().foodTest();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

  getData() async {
    //List<String>? list = await RemoteService().getFoods();
    user = await RemoteService().postHealthInformation(
        height.value,
        weight.value,
        goalWeight.value,
        ageInputController.text.toString(),
        gender.value,
        goal.value,
        exercise.value);
    print("JSON: ${user?.toJson()}");
  }
}
