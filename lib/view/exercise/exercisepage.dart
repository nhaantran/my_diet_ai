import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_diet/common/entities/exercise.dart';
import 'package:my_diet/common/routes/names.dart';
import 'package:my_diet/view/exercise/widget/ExerciseTile.dart';

import '../../common/values/colors.dart';
import 'exercisecontroller.dart';

class ExercisePage extends GetView<ExerciseController> {
  ExercisePage({super.key});
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');
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
        children: [
          Container(
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
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.brand05),
                    borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                    ),
              ),
            ),
          ),
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
}
