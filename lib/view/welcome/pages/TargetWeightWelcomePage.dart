// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../../common/values/colors.dart';

class TargetWeightWelcomePage extends GetView<WelcomeController> {
  final VoidCallback onTap;
  final VoidCallback back;
  TargetWeightWelcomePage({
    required this.onTap,
    required this.back,
  });
  final RulerPickerController? rulerPickerController =
      RulerPickerController(value: 80);
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
                    child: Icon(Icons.arrow_back_ios_new),
                    foregroundColor: AppColors.brand05,
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
                    },
                    child: Icon(Icons.arrow_forward_ios),
                    foregroundColor: AppColors.white,
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
                    "What's your goal weight?",
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
                          rulerBackgroundColor:
                              AppColors.brand07.withOpacity(0.3),
                          controller: rulerPickerController!,
                          beginValue: 40,
                          endValue: 200,
                          initValue: controller.weight.value,
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
                    "${controller.weight} kg",
                    style: const TextStyle(
                        color: AppColors.brand03,
                        fontWeight: FontWeight.bold,
                        fontSize: 60),
                  ),
                ],
              )),
        ));
  }
}
