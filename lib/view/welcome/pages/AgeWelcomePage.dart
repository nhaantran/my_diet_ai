// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../welcomepage.dart';
import '../widgets/WelcomeCard.dart';

class AgeWelcomePage extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback back;
  var hasEntered = false.obs;
  AgeWelcomePage({
    Key? key,
    required this.onTap,
    required this.back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                visible: hasEntered.value == true ? true : false,
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
                  "How old are you?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Gothic',
                      fontWeight: FontWeight.w900),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    //autofocus: true,
                    onEditingComplete: () {
                      hasEntered = true.obs;
                      onTap();
                    },
                    decoration: InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 3, color: AppColors.brand05),
                          borderRadius:
                              BorderRadius.circular(20.0) //<-- SEE HERE
                          ),
                    ),
                  ),
                )
              ],
            ))));
  }
}
