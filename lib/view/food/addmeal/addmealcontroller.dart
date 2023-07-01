import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:my_diet/common/entities/food.dart';
import 'package:my_diet/services/remote_service.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../../common/routes/names.dart';
import '../../../common/values/colors.dart';
import '../foodcontroller.dart';

class AddMealController extends GetxController {
  var servingSize = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final List<Text> textList = List<Text>.generate(
    1000,
    (index) => Text(
      '$index gram',
    ),
  );
  changeServingSize(int index) {
    servingSize.value = index;
  }

  openBottomPicker(
      BuildContext context, Product product, double? servingQuantity) {
    if (servingQuantity != null) {
      BottomPicker(
        items: textList,
        title: 'PerServing: $servingQuantity',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        backgroundColor: AppColors.white.withOpacity(0.9),
        selectedItemIndex: servingQuantity > 0.0 ? servingQuantity.round() : 1,
        onChange: (index) {
          changeServingSize(index);
        },
        onSubmit: (index) {
          logFood(product, index);
        },
        buttonAlignement: MainAxisAlignment.center,
        displayButtonIcon: false,
        buttonText: 'Confirm',
        buttonTextStyle: const TextStyle(color: Colors.white),
        buttonSingleColor: AppColors.brand05,
      ).show(context);
    } else {
      logFood(product, 100);
    }
  }

  logFood(Product product, int servingSize) {
    var food = {
      "name": product.productName,
      "calories": product.nutriments!
          .getValue(Nutrient.energyKCal, PerSize.oneHundredGrams)
          ?.toStringAsFixed(1),
      "serving_size_g": servingSize,
      "fat_total_g": product.nutriments!
          .getValue(Nutrient.fat, PerSize.oneHundredGrams)
          ?.toStringAsFixed(1),
      "protein_g": product.nutriments!
          .getValue(Nutrient.proteins, PerSize.oneHundredGrams)
          ?.toStringAsFixed(1),
      "carbohydrates_total_g": product.nutriments!
          .getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams)
          ?.toStringAsFixed(1),
    };
    var addedFood = Food.fromJson(food);
    FoodController.addFood(addedFood);
    Get.back();
    // Get.offAndToNamed(AppRoutes.Food);
  }
}
