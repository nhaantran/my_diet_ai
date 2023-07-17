import 'dart:convert';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:my_diet/common/routes/names.dart';
import 'package:my_diet/common/store/user.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_diet/common/entities/entities.dart';
import 'package:my_diet/common/entities/user.dart';
import 'package:my_diet/view/home/homecontroller.dart';
import 'package:my_diet/view/profile/state.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../common/values/colors.dart';
import '../../common/values/goal.dart';
import '../../common/widgets/toast.dart';

class ProfileController extends GetxController {
  final ProfileState state = ProfileState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://wwww.googleapis.com/auth/contacts.readonly'
  ]);

  asyncLoadAllData() async {
    String profile = await UserStore.to.getProfile();
    if (profile.isNotEmpty) {
      UserLoginResponseEntity userdata =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      state.head_detail.value = userdata;
    }
  }

  changeWeight(int index) async {
    HomeController.weight.value = index.toString();
  }

  changeGoalWeight(int index) async {
    HomeController.goalWeight.value = index.toString();
  }

  var currentHeight = "".obs;
  changeHeight(int index) async {
    HomeController.height.value = index.toString();
  }

  // openBottomPickerCalories(BuildContext context, int duration) {
  //   BottomPicker(
  //     items: caloriesList,
  //     title: 'Estimate calories burned or just leave it 0',
  //     titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //     backgroundColor: AppColors.white.withOpacity(0.9),
  //     selectedItemIndex: 12,
  //     onSubmit: (index) {
  //       logUntrackedCalories(duration, (index * 50));
  //     },
  //     buttonAlignement: MainAxisAlignment.center,
  //     displayButtonIcon: false,
  //     buttonText: 'Confirm',
  //     buttonTextStyle: const TextStyle(color: Colors.white),
  //     buttonSingleColor: AppColors.brand05,
  //   ).show(context);
  // }

  // openBottomPicker(BuildContext context) {
  //   BottomPicker(
  //     items: durationList,
  //     title: 'Choose duration',
  //     titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //     backgroundColor: AppColors.white.withOpacity(0.9),
  //     selectedItemIndex: 12,
  //     onSubmit: (index) {
  //       FocusScope.of(context).requestFocus(FocusNode());

  //       loadData(index);
  //     },
  //     buttonAlignement: MainAxisAlignment.center,
  //     displayButtonIcon: false,
  //     buttonText: 'Confirm',
  //     buttonTextStyle: const TextStyle(color: Colors.white),
  //     buttonSingleColor: AppColors.brand05,
  //   ).show(context);
  // }

  final List<Text> goalList = [
    const Text("Stay Healthy"),
    const Text("Lose Weight"),
    const Text("Gain Weight"),
  ];
  var rulerPickerController = RulerPickerController().obs;
  var currentGoal = 0.obs;
  var updateGoal = HomeController.goal.value.obs;
  openBottomPickerGoal(BuildContext context) {
    BottomPicker(
      items: goalList,
      title: 'Change your goal',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      backgroundColor: AppColors.white.withOpacity(0.9),
      selectedItemIndex: 0,
      displaySubmitButton: false,
      onChange: (index) {
        currentGoal.value = index;
      },
      onClose: () {
        Get.dialog(AlertDialog(
          title: const Text("Do you want to keep the change?"),
          actions: [
            TextButton(
                child:
                    const Text("No", style: TextStyle(color: AppColors.error)),
                onPressed: () {
                  Get.back();
                }),
            TextButton(
                child: const Text("Yes"),
                onPressed: () async {
                  if (currentGoal.value == 0) {
                    updateGoal.value = Goal.maintenance;
                  } else if (currentGoal.value == 1) {
                    updateGoal.value = Goal.loseWeight;
                  } else {
                    updateGoal.value = Goal.gainWeight;
                  }
                  setRulerValue();
                  Get.back();

                  Get.dialog(AlertDialog(
                    title: const Text("Update goal weight"),
                    content: Obx(() => SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: RulerPicker(
                                  controller: rulerPickerController.value,
                                  beginValue: beginValue.value,
                                  endValue: endValue.value,
                                  initValue:
                                      int.parse(HomeController.weight.value),
                                  onBuildRulerScalueText: (index, scaleValue) {
                                    return scaleValue.toString();
                                  },

                                  scaleLineStyleList: const [
                                    ScaleLineStyle(
                                        color: AppColors.brand07,
                                        width: 2,
                                        height: 40,
                                        scale: 0),
                                    ScaleLineStyle(
                                        color: AppColors.brand07,
                                        width: 1,
                                        height: 25,
                                        scale: 5),
                                    ScaleLineStyle(
                                        color: AppColors.brand07,
                                        width: 0,
                                        height: 0,
                                        scale: -1),
                                  ],
                                  onValueChange: (value) => {
                                    changeGoalWeight(
                                      value,
                                    )
                                  },
                                  width: 200,
                                  height: 100,
                                  // rulerMarginTop: 8,
                                  marker: Container(
                                      width: 8,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: AppColors.brand05
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                "${HomeController.weight.value} kg",
                                style: const TextStyle(
                                    color: AppColors.brand03,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60),
                              ),
                            ],
                          ),
                        )),
                    actions: [
                      TextButton(
                          child: const Text("Close",
                              style: TextStyle(color: AppColors.error)),
                          onPressed: () {
                            Get.back();
                            HomeController.weight.value =
                                HomeController.currentWeight.value;
                          }),
                      TextButton(
                          child: const Text("Ok"),
                          onPressed: () async {
                            await HomeController.updateWeight(
                                int.parse(HomeController.weight.value));
                            Get.back();
                            toastInfo(msg: "Update goal successful");
                          }),
                    ],
                  ));
                }),
          ],
        ));
        //openBottomPickerCalories(context, durationExercise.value);
      },
    ).show(context);
  }

  var beginValue = 0.obs;
  var endValue = 0.obs;

  setRulerValue() {
    rulerPickerController.value = RulerPickerController(
        value: int.parse(HomeController.currentWeight.value));
    if (updateGoal.value == Goal.loseWeight) {
      beginValue.value = 40;
      endValue.value = int.parse(HomeController.currentWeight.value);
    } else if (updateGoal.value == Goal.gainWeight) {
      beginValue.value = int.parse(HomeController.currentWeight.value);
      endValue.value = 200;
    } else {
      beginValue.value = int.parse(HomeController.currentWeight.value) - 5;
      endValue.value = int.parse(HomeController.currentWeight.value) + 5;
    }
  }

  openDialog() {
    Get.dialog(AlertDialog(
      title: const Text("Do you want to keep the change?"),
      actions: [
        TextButton(
            child: const Text("No", style: TextStyle(color: AppColors.error)),
            onPressed: () {
              Get.back();
            }),
        TextButton(
            child: const Text("Yes"),
            onPressed: () async {
              var updateGoal;
              if (currentGoal.value == 0) {
                updateGoal = Goal.maintenance;
              } else if (currentGoal.value == 1) {
                updateGoal = Goal.loseWeight;
              }
              // await HomeController.updateWeight(
              //     int.parse(HomeController.weight.value));
              // await controller.caloriesCount();
              // Get.back();
              // toastInfo(msg: "Update weight successful");
            }),
      ],
    ));
  }

  Future<void> onLogOut() async {
    UserStore.to.onLogout();
    await _googleSignIn.signOut();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();
    List MyList = [
      {"name": "Account", "icon": "assets/icons/1.png", "route": "/account"},
      {"name": "Chat", "icon": "assets/icons/2.png", "route": "/chat"},
      {
        "name": "Notification",
        "icon": "assets/icons/3.png",
        "route": "/notification"
      },
      {"name": "Privacy", "icon": "assets/icons/4.png", "route": "/privacy"},
      {"name": "Help", "icon": "assets/icons/5.png", "route": "/help"},
      {"name": "About", "icon": "assets/icons/6.png", "route": "/about"},
      {"name": "Logout", "icon": "assets/icons/7.png", "route": "/logout"},
    ];

    for (int i = 0; i < MyList.length; i++) {
      MeListItem result = MeListItem();
      result.icon = MyList[i]["icon"];
      result.name = MyList[i]["name"];
      result.route = MyList[i]["route"];
      state.meListItem.add(result);
    }
  }
}
