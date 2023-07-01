import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/services/firestore_service.dart';
import 'package:my_diet/services/remote_service.dart';

import '../../common/entities/exercise.dart';
import '../../common/values/colors.dart';

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

  final List<Text> textList = List<Text>.generate(
    180,
    (index) => Text(
      '$index minutes',
    ),
  );

  openBottomPicker(BuildContext context) {
    BottomPicker(
      items: textList,
      title: 'Choose duration',
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 60,
      onSubmit: (index) {
        loadData(index);
      },
      buttonAlignement: MainAxisAlignment.center,
      displayButtonIcon: false,
      buttonText: 'Confirm',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.brand05,
    ).show(context);
  }

  logExercise(Exercise exercise) async {
    await FireStoreSerivce().addExercise(exercise);
  }

  loadData(int duration) async {
    var exercises = await RemoteService()
        .getExercise(exerciseSearchController.text, duration);
    if (exercises != null) {
      exerciseList.value = exercises;
    }
  }
}
