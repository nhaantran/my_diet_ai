// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/view/food/addmeal/addmealcontroller.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../../common/values/colors.dart';

class AddMealPage extends GetView<AddMealController> {
  final Product? product;

  const AddMealPage({
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product details:",
          style: TextStyle(fontFamily: "Gothic"),
        ),
        centerTitle: true,
        backgroundColor: AppColors.brand06,
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 250.h,
                width: 300.w,
                child: CachedNetworkImage(
                  imageUrl: product!.imageFrontUrl.toString(),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/null_image.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Container(
              //   height: 250.h,
              //   width: 300.w,
              //   decoration: BoxDecoration(
              //       color: AppColors.white,
              //       image: DecorationImage(
              //           fit: BoxFit.contain,
              //           image: NetworkImage(product!.imageFrontUrl.toString()
              //              ))),
              // ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8.0),
                child: Divider(
                  height: 2,
                  thickness: 2,
                ),
              ),
              ListTile(
                title: const Text("Product name:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Container(
                  width: 200.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    product!.productName.toString(),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Serving size:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("${product!.servingQuantity} gram"),
              ),
              ListTile(
                title: const Text("Calories:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Container(
                  width: 150.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                      "${product!.nutriments!.getValue(Nutrient.energyKCal, PerSize.serving)?.toStringAsFixed(1)} calories"),
                ),
              ),
              ListTile(
                title: const Text("Total carbohydrates:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    "${product!.nutriments?.getValue(Nutrient.carbohydrates, PerSize.serving)?.toStringAsFixed(1)} gram carbs"),
              ),
              ListTile(
                title: const Text("Total proteins:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    "${product!.nutriments?.getValue(Nutrient.proteins, PerSize.serving)?.toStringAsFixed(1)} gram pros"),
              ),
              ListTile(
                title: const Text("Total fat:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    "${product!.nutriments?.getValue(Nutrient.fat, PerSize.serving)?.toStringAsFixed(1)} gram fat"),
              ),
              ListTile(
                title: const Text("Total sugars:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    "${product!.nutriments?.getValue(Nutrient.sugars, PerSize.serving)?.toStringAsFixed(1)} gram sugars"),
              ),
              ListTile(
                title: const Text("Total fiber:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    "${product!.nutriments?.getValue(Nutrient.fiber, PerSize.serving)?.toStringAsFixed(1)} gram fiber"),
              ),
              ListTile(
                title: const Text("Total sodium:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                    "${product!.nutriments?.getValue(Nutrient.sodium, PerSize.serving)?.toStringAsFixed(1)} gram sodium"),
              ),
            ]),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10.0.w, left: 10.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialButton(
                  color: AppColors.brand06,
                  onPressed: () {
                    controller.openBottomPicker(
                        context, product!, product!.servingQuantity);
                    // Get.bottomSheet(
                    //   SizedBox(
                    //     height: 150,

                    //     child: Row(children: [

                    //       NumberPicker(
                    //       minValue: 0,
                    //       maxValue: 100,
                    //       value: 50,
                    //       onChanged: (value) => {
                    //         controller.changeWeight(
                    //           value,
                    //         )
                    //       },
                    //     ),
                    //     ],)
                    //   )
                    // );
                    //controller.logFood(product!);
                  },
                  child: const Text(
                    "Log food",
                    style: TextStyle(color: AppColors.white),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
