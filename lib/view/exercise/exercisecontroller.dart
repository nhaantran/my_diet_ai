import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_diet/services/firestore_service.dart';
import 'package:my_diet/services/remote_service.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';

import '../../common/entities/exercise.dart';
import '../../common/entities/untracked.dart';
import '../../common/values/colors.dart';
import '../home/homecontroller.dart';

class ExerciseController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  var isLoading = true.obs;
  var startLoading = false.obs;
  var durationExercise = 0.obs;
  var exerciseList = <Exercise>[].obs;
  final TextEditingController exerciseSearchController =
      TextEditingController();
  final TextEditingController untrackedInputController =
      TextEditingController();
  final untrackedFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  final List<Text> durationList = List<Text>.generate(
    36,
    (index) => Text(
      '${index * 5} minutes',
    ),
  );
  final List<Text> caloriesList = List<Text>.generate(
    100,
    (index) => Text(
      '${index * 50} calories',
    ),
  );
  openBottomPickerCalories(BuildContext context, int duration) {
    BottomPicker(
      items: caloriesList,
      title: 'Estimate calories burned or just leave it 0',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 12,
      onSubmit: (index) {
        logUntrackedCalories(duration, (index * 50));
      },
      buttonAlignement: MainAxisAlignment.center,
      displayButtonIcon: false,
      buttonText: 'Confirm',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.brand05,
    ).show(context);
  }

  openBottomPicker(BuildContext context) {
    BottomPicker(
      items: durationList,
      title: 'Choose duration',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 12,
      onSubmit: (index) {
        FocusScope.of(context).requestFocus(FocusNode());

        loadData(index);
      },
      buttonAlignement: MainAxisAlignment.center,
      displayButtonIcon: false,
      buttonText: 'Confirm',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: AppColors.brand05,
    ).show(context);
  }

  openBottomPickerDuration(BuildContext context) {
    BottomPicker(
      items: durationList,
      title: 'Choose duration',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 12,
      displaySubmitButton: false,
      onChange: (index) {
        durationExercise.value = index * 5;
      },
      onClose: () {
        openBottomPickerCalories(context, durationExercise.value);
      },
    ).show(context);
  }

  logUntrackedCalories(int duration, int calories) async {
    var untrackedExerciseCalories = {
      "description": untrackedInputController.text,
      "duration": duration,
      "calories": calories
    };
    untrackedInputController.clear();
    var addedUntrackedExercise =
        UntrackedExercise.fromJson(untrackedExerciseCalories);
    await FireStoreSerivce()
        .addUntrackedExerciseCalories(addedUntrackedExercise);
    DailyController().getCalories(DateTime.now());
    DailyController().getListOfDialy();
    await HomeController().caloriesCount();
    getSnackBar();
  }

  logExercise(Exercise exercise) async {
    await FireStoreSerivce().addExercise(exercise);
    DailyController().getCalories(DateTime.now());
    DailyController().getListOfDialy();
    await HomeController().caloriesCount();
    getSnackBar();
  }

  getSnackBar() {
    Get.snackbar(
      'Add exercise success',
      'You can check your calories in Daily Journey sceen',
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
    );
  }

  loadData(int duration) async {
    var exercises = await RemoteService()
        .getExercise(exerciseSearchController.text, duration);
    if (exercises != null) {
      exerciseList.value = exercises;
    }
  }
}
