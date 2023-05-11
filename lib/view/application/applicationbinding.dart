import 'package:get/get.dart';
import 'package:my_diet/view/daily/dailycontroller.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import 'applicationcontroller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DailyController>(() => DailyController());
  }
}
