import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:my_diet/view/signin/signincontroller.dart';
import 'package:my_diet/view/signup/signupcontroller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
