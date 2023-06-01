import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/services/remote_service.dart';

import '../../common/entities/exercise.dart';

class ExerciseController extends GetxController {
  var isLoading = true.obs;
  var startLoading = false.obs;
  var exerciseList = <Exercise>[].obs;
  final TextEditingController exerciseSearchController =
      TextEditingController();
  @override
  void onInit() {
    
    super.onInit();
  }

  loadData() async {
    var exercises =
        await RemoteService().getExercise(exerciseSearchController.text);
    if (exercises != null) {
      exerciseList.value = exercises;
    }
  }
}
