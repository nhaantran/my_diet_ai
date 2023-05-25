import 'package:get/get.dart';
import 'package:my_diet/view/exercise/exercisecontroller.dart';
import 'package:my_diet/view/food/addmeal/addmealcontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';


class ExerciseBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ExerciseController>(() => ExerciseController());
  
  }
}
