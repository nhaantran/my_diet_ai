import 'package:get/get.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
