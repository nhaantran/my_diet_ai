import 'package:get/get.dart';
import 'package:my_diet/common/entities/user.dart';

class ProfileState {
  var head_detail = Rx<UserLoginResponseEntity?>(null);
  RxList<MeListItem> meListItem = <MeListItem>[].obs;
}
