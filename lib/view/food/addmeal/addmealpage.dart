// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/view/food/addmeal/addmealcontroller.dart';

import 'package:my_diet/view/food/foodcontroller.dart';

import '../../../common/values/colors.dart';

class AddMealPage extends GetView<AddMealController> {
  const AddMealPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.white,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
            color: AppColors.white,
          )
        ],
        title: const Text(
          "Create a meal",
          style: TextStyle(fontFamily: "Gothic"),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 310.h,
            decoration: const BoxDecoration(
                color: AppColors.brand06,
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/add_food_background.png"))),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                    onPressed: () {
                      print("add photo");
                    },
                    iconSize: 36.0,
                    color: AppColors.brand05,
                    icon: Icon(Icons.camera_alt_outlined),
                  ),
                ),
                const Text(
                  "Add photo",
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: "Gothic",
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                ),
                labelText: "Search meal's name...",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.brand05),
                    borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: const Divider(
              height: 2,
              thickness: 2,
            ),
          ),
          ListTile(
            title: Text("Meal Items",
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
