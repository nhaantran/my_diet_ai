import 'package:get/get.dart';
import 'package:my_diet/view/home/homecontroller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
    //Get.lazyPut<FoodsController>(() => FoodsController());
  }
}
