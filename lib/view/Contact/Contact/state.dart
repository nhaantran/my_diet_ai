import 'package:get/get.dart';
import 'package:my_diet/common/entities/user.dart';

class ContactState {
  var count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}
