import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/routes/names.dart';

class SignUpController extends GetxController {
  SignUpController();

  handleSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }

  moveToSignIn() async {
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
