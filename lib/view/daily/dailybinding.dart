import 'package:get/get.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import 'dailycontroller.dart';

class DailyBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DailyController>(() => DailyController());

    //Get.lazyPut<FoodsController>(() => FoodsController());
  }
}
