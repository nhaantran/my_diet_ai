import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../welcome/welcomecontroller.dart';

class HomeController extends GetxController {
  var baseGoal = 0.0.obs;
  var caloriesFood = 300.obs;
  var caloriesExercise = 0.obs;
  var waterIntake = 0.5.obs;
  var waterNeeded = 1.5.obs;
  var streaks = 0.obs;
  var progress = 0.0.obs;
  var remaining = 0.0.obs;
  HomeController();
}
