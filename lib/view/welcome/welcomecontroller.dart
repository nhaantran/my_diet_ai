import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/routes/names.dart';
import '../../common/store/config.dart';

class WelcomeController extends GetxController {
  var index = 0.obs;

  var beginHeight = 100.obs;
  var height = 150.obs;
  var endHeight = 200.obs;
  var weight = 800.obs;
  changePage(int index) async {
    this.index.value = index;
  }

  changeWeight(int index) async {
    weight.value = index;
  }

  changeHeight(int begin, int value, int end) async {
    beginHeight.value = begin;
    height.value = value;
    endHeight.value = end;
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

    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
