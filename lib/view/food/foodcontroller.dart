import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_diet/services/remote_service.dart';

class FoodController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();

    getData();
    tabController = TabController(length: 4, vsync: this);
  }

  getData() async {
    List<String>? list = await RemoteService().getFoods();
  }
}
