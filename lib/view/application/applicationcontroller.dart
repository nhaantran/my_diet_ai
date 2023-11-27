import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:my_diet/services/remote_service.dart';

import '../../common/routes/names.dart';
import '../../common/values/colors.dart';
import '../food/addmeal/addmealbinding.dart';
import '../food/addmeal/addmealpage.dart';

class ApplicationController extends GetxController {
  ApplicationController();
  var page = 0.obs;
  var isProductFounded = true.obs;
  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomeTabs;

  void handlePageChanged(int index) {
    page.value = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  void addExerciseNavigation() {
    Get.toNamed(AppRoutes.Exercise);
  }

  void addFoodNavigation() {
    Get.toNamed(AppRoutes.Food);
    //var data = await Get.toNamed(AppRoutes.Food);

    //Get.to(AppRoutes.Food);
  }

  getBarCode(String barCode) async {
    var product = await RemoteService().getFoodfromBarCode(barCode);
    if (product != null) {
      isProductFounded.value = true;
      Get.to(
          () => AddMealPage(
                product: product,
              ),
          binding: AddMealBinding());
    } else {
      isProductFounded.value = false;
    }
  }

  scanBarCode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) async {});
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['DashBoard', "2", "3", "4"];
    bottomeTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/dashboard.png"),
            color: AppColors.thirdElementText,
          ),
          label: "Dashboard",
          activeIcon: ImageIcon(
            AssetImage("assets/icons/dashboard.png"),
            color: AppColors.brand05,
          )),
      const BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/diary.png"),
            color: AppColors.thirdElementText,
          ),
          label: "Diary",
          activeIcon: ImageIcon(
            AssetImage("assets/icons/diary.png"),
            color: AppColors.brand05,
          )),
      const BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/message.png"),
            color: AppColors.thirdElementText,
          ),
          label: "Message",
          activeIcon: ImageIcon(
            AssetImage("assets/icons/message.png"),
            color: AppColors.brand05,
          )),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline_outlined,
            color: AppColors.thirdElementText,
          ),
          label: "Setting",
          activeIcon: Icon(
            Icons.person_outline_outlined,
            color: AppColors.brand05,
          )),
    ];

    pageController = PageController(initialPage: page.value, keepPage: false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
