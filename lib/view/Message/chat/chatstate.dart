import 'package:get/get.dart';
import 'package:my_diet/common/entities/entities.dart';
import 'package:my_diet/common/entities/msgcontent.dart';

class ChatState {
  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_uid = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var to_location = "unknown".obs;
}
