import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_diet/view/exercise/exercisebinding.dart';
import 'package:my_diet/view/exercise/exercisepage.dart';
import 'package:my_diet/view/food/addmeal/addmealbinding.dart';
import 'package:my_diet/view/food/addmeal/addmealpage.dart';
import 'package:my_diet/view/profile/profilebinding.dart';
import 'package:my_diet/view/profile/profilepage.dart';
import 'package:my_diet/view/welcome/welcomebinding.dart';
import 'package:my_diet/view/welcome/welcomepage.dart';
import '../../view/application/applicationbinding.dart';
import '../../view/application/applicationpage.dart';
import '../../view/food/foodbinding.dart';
import '../../view/food/foodpage.dart';
import '../../view/signin/signinbinding.dart';
import '../../view/signin/signinpage.dart';
import '../../view/signup/signupbinding.dart';
import '../../view/signup/signuppage.dart';
import '../middlewares/router_auth.dart';
import '../middlewares/router_welcome.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const Application = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      // middlewares: [
      //   RouteWelcomeMiddleware(priority: 0),
      // ]
    ),

    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => SignInPage(),
      binding: SignInBinding(),
      transition: Transition.native,
      fullscreenDialog: true,
      popGesture: false,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
      transition: Transition.native,
      popGesture: false,
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    // // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      transition: Transition.native,

      // middlewares: [
      //   RouteAuthMiddleware(priority: 1),
      // ],
    ),
    GetPage(
        name: AppRoutes.Food,
        page: () => FoodPage("Breakfast"),
        binding: FoodBinding(),
        transition: Transition.downToUp),

    GetPage(
      name: AppRoutes.AddMeal,
      page: () => AddMealPage(),
      binding: AddMealBinding(),
    ),
    GetPage(
      name: AppRoutes.Profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.Exercise,
      page: () => ExercisePage(),
      binding: ExerciseBinding(),
    ),
    // GetPage(
    //     name: AppRoutes.Contact,
    //     page: () => FoodsPage(),
    //     binding: FoodsBinding()),
/*
    // 最新路由
    // 首页
    GetPage(name: AppRoutes.Contact, page: () => ContactPage(), binding: ContactBinding()),
    //消息
    GetPage(name: AppRoutes.Message, page: () => MessagePage(), binding: MessageBinding()),
    //我的
    GetPage(name: AppRoutes.Me, page: () => MePage(), binding: MeBinding()),
    //聊天详情
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),

    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),*/
  ];
}
