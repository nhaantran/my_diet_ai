import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  var baseGoal = 150.obs;
  var caloriesFood = 0.obs;
  var caloriesExercise = 0.obs;
  HomeController();
}
