import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/common/entities/exercise.dart';

import '../../common/values/colors.dart';
import 'exercisecontroller.dart';

class ExercisePage extends GetView<ExerciseController> {
  ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.brand05,
          onPressed: () {
            //Navigator.of(context).pop();
            Get.back();
            //Get.offNamed(AppRoutes.Exercise);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Add Exercise",
          style: TextStyle(
              color: AppColors.fontDark,
              fontFamily: "Gothic",
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _tabBar(),
          _tabBarView(context),
          Expanded(
              child: Container(
            color: AppColors.white,
            child: Obx(() {
              if (controller.isLoading.value && controller.startLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.separated(
                itemCount: controller.exerciseList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey<Exercise>(controller.exerciseList[index]),
                    background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.white,
                        )),
                    onDismissed: (DismissDirection direction) {
                      controller.exerciseList.removeAt(index);
                      //controller.getTotalCalories();
                    },
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        controller.exerciseList[index].name.toUpperCase(),
                        style: const TextStyle(
                            fontFamily: "OpenSans",
                            color: AppColors.brand04,
                            fontSize: 30),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                            style: const TextStyle(fontFamily: "OpenSans"),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${controller.exerciseList[index].caloriesPerHour.toString()} calories\n",
                                  style: const TextStyle(
                                    color: AppColors.brand05,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextSpan(
                                  text:
                                      "${controller.exerciseList[index].durationMinutes.toString()} minute",
                                  style: const TextStyle(
                                    color: AppColors.brand05,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ]),
                      ),
                      trailing: Wrap(children: [
                        IconButton(
                            onPressed: () {
                              controller
                                  .logExercise(controller.exerciseList[index]);
                            },
                            icon: const Icon(Icons.add_box_outlined,
                                color: AppColors.brand05))
                      ]),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 10,
                    thickness: 1,
                  );
                },
              );
            }),
          )),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Center(
      child: Container(
        height: 48.h,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabBar(
              isScrollable: true,
              labelColor: AppColors.white,
              controller: controller.tabController,
              unselectedLabelColor: AppColors.fontDark,
              indicator: BoxDecoration(
                color: AppColors.brand05,
                borderRadius: BorderRadius.circular(24),
              ),
              tabs: const [
                Tab(
                  text: "Add exercise",
                ),
                Tab(
                  text: "Untracked exercise",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBarView(BuildContext context) {
    return Container(
      height: 150.h,
      child: TabBarView(controller: controller.tabController, children: [
        _searchExercise(context),
        _unTracked(context),
      ]),
    );
  }

  Widget _searchExercise(BuildContext context) {
    return Container(
      height: 60.h,
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onEditingComplete: () {
          controller.openBottomPicker(context);
          //print(controller.exerciseSearchController.text);
        },
        controller: controller.exerciseSearchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.exerciseSearchController.text = '';
            },
          ),
          hintText: "Search all exercises...",
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: AppColors.brand05),
              borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
              ),
        ),
      ),
    );
  }

  Widget _unTracked(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0.w),
                  child: const Text(
                    "Description of untracked calories",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
                Container(
                  width: 300.w,
                  height: 70.h,
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: controller.untrackedFormKey,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      onEditingComplete: () {
                        if (controller.untrackedFormKey.currentState!
                            .validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can\' not be empty';
                        }
                        return null;
                      },
                      controller: controller.untrackedInputController,
                      decoration: InputDecoration(
                        //hintText: "Input the foods",
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.brand05),
                            borderRadius:
                                BorderRadius.circular(20.0) //<-- SEE HERE
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(""),
                SizedBox(
                  height: 70.0.h,
                  child: IconButton(
                      onPressed: () {
                        if (controller.untrackedFormKey.currentState!
                            .validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.openBottomPickerDuration(context);
                        } else {
                          Get.snackbar(
                            "Failed",
                            "Please input again",
                            icon: const Icon(Icons.warning, color: Colors.red),
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.add_box_outlined,
                        size: 32.0,
                        color: AppColors.brand05,
                      )),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                      color: AppColors.fontMid,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.question_mark,
                    size: 16.0,
                    color: AppColors.white,
                  )),
            ),
            const Expanded(
              child: Text(
                "E.g. Going to the gym or just playing around, ... ",
                style: TextStyle(
                    color: AppColors.fontMid,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ],
    );
  }
}
