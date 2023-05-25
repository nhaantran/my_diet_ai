import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/routes/names.dart';

class SignInController extends GetxController {
  var index = 0.obs;

  SignInController();
  changePage(int index) async {
    this.index.value = index;
  }

  moveToSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
  }

  handleSignIn() async {
    Get.offAndToNamed(AppRoutes.Application);
  }
}
