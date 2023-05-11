import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/routes/names.dart';
import '../../common/values/colors.dart';

class ApplicationController extends GetxController {
  ApplicationController();
  var page = 0.obs;

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomeTabs;

  void handlePageChanged(int index) {
    page.value = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['1', "2", "3", "4"];
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
            AssetImage("assets/icons/plus.png"),
            size: 36.0,
            color: AppColors.brand05,
          ),
          label: "",
          activeIcon: ImageIcon(
            AssetImage("assets/icons/plus.png"),
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
          icon: ImageIcon(
            AssetImage("assets/icons/setting.png"),
            color: AppColors.thirdElementText,
          ),
          label: "Setting",
          activeIcon: ImageIcon(
            AssetImage("assets/icons/setting.png"),
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
