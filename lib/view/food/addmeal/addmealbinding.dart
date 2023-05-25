import 'package:get/get.dart';
import 'package:my_diet/view/food/addmeal/addmealcontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';


class AddMealBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AddMealController>(() => AddMealController());
  
  }
}
