import 'package:get/get.dart';
import 'package:my_diet/view/food/addmeal/addmealcontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import 'foodcontroller.dart';

class FoodBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<AddMealController>(() => AddMealController());

    //Get.lazyPut<FoodsController>(() => FoodsController());
  }
}
