import 'package:get/get.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';
import 'package:my_diet/view/exercise/exercisecontroller.dart';
import 'package:my_diet/view/food/addmeal/addmealcontroller.dart';
import 'package:my_diet/view/food/foodcontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';
import 'package:my_diet/view/message/chat/chatindex.dart';

import '../Contact/Contact/contactcontroller.dart';
import '../profile/profilecontroller.dart';
import 'applicationcontroller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DailyController>(() => DailyController());
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<AddMealController>(() => AddMealController());
    Get.lazyPut<ExerciseController>(() => ExerciseController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
