import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:get/get.dart';
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
  static var goalWeight = 80.obs;
  static var weight = 75.obs;
  static var beginValue = 0.obs;
  static var endValue = 0.obs;
  final TextEditingController ageInputController = TextEditingController();
  var rulerPickerController = RulerPickerController().obs;
  static CustomerData? user;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  setRulerValue() {
    goalWeight.value = weight.value;
    rulerPickerController.value = RulerPickerController(value: weight.value);
    if (goal.value == Goal.loseWeight) {
      beginValue.value = 40;
      endValue.value = weight.value;
    } else if (goal.value == Goal.gainWeight) {
      beginValue.value = weight.value;
      endValue.value = 200;
    } else {
      beginValue.value = weight.value - 5;
      endValue.value = weight.value + 5;
    }
  }

  changePage(int index) async {
    this.index.value = index;
    progressValue.value = index / 8;
  }

  changeWeight(int index) async {
    weight.value = index;
  }

  changeGoalWeight(int index) async {
    goalWeight.value = index;
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
