import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/entities/userhealt.dart';
import '../../common/routes/names.dart';
import '../../services/remote_service.dart';

class WelcomeController extends GetxController {
  var name = "nhaantran".obs;
  var age = 21.obs;
  var index = 0.obs;
  var gender = "male".obs;
  var goal = "maintenance".obs;
  var exercise = "moderate".obs;
  var progressValue = 0.0.obs;
  var height = 170.obs;
  var goalWeight = 80.obs;
  var weight = 75.obs;
  final TextEditingController ageInputController = TextEditingController();

  static CustomerData? user ;

  changePage(int index) async {
    this.index.value = index;
    progressValue.value = index / 10;
  }

  changeWeight(int index) async {
    weight.value = index;
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
    getData();
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
  }
}
