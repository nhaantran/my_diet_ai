// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../../common/values/colors.dart';

class CurrentWeightWelcomePage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;
  CurrentWeightWelcomePage({
    required this.onTap,
    required this.back,
  });
  final RulerPickerController? rulerPickerController =
      RulerPickerController(value: 150);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() => Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visibility(
                  visible: true,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.brand09,
                    onPressed: () {
                      back();
                    },
                    foregroundColor: AppColors.brand05,
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Visibility(
                  visible: true,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.brand05,
                    onPressed: () {
                      onTap();
                      controller.setRulerValue();
                    },
                    foregroundColor: AppColors.white,
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                )
              ],
            ),
          ),
          body: Container(
              color: AppColors.monochromatic09,
              width: double.infinity,
              height: double.infinity,
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/images/gym.jpg"),
              //         fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "What's your weight?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Gothic',
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Obx(
                        () => RulerPicker(
                          controller: rulerPickerController!,
                          beginValue: 40,
                          endValue: 200,
                          initValue: WelcomeController.weight.value,
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
                            controller.changeWeight(
                              value,
                            )
                          },
                          width: 400,
                          height: 100,
                          rulerMarginTop: 8,
                          marker: Container(
                              width: 8,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.brand05.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      )),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "${WelcomeController.weight} kg",
                    style: const TextStyle(
                        color: AppColors.brand03,
                        fontWeight: FontWeight.bold,
                        fontSize: 60),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 30.0.h, right: 80.w, left: 60.w),
                    child: Row(
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
                            "Don't worry if you don't know it precisely-you can change this later",
                            style: TextStyle(
                                color: AppColors.fontMid,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
