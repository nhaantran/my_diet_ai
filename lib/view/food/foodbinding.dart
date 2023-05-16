import 'package:get/get.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import 'foodcontroller.dart';

class FoodBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FoodController>(() => FoodController());

    //Get.lazyPut<FoodsController>(() => FoodsController());
  }
}
