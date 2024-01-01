import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/exercise/exercisebinding.dart';
import 'package:my_diet/view/exercise/exercisepage.dart';
import 'package:my_diet/view/food/addmeal/addmealbinding.dart';
import 'package:my_diet/view/food/addmeal/addmealpage.dart';
import 'package:my_diet/view/profile/profilepage.dart';
import 'package:my_diet/view/profile/profilebinding.dart';
import 'package:my_diet/view/welcome/welcomebinding.dart';
import 'package:my_diet/view/welcome/welcomepage.dart';
import '../../view/Contact/Contact/contactbinding.dart';
import '../../view/Contact/Contact/contactpage.dart';
import '../../view/application/applicationbinding.dart';
import '../../view/application/applicationpage.dart';
import '../../view/food/foodbinding.dart';
import '../../view/food/foodpage.dart';
import '../../view/message/chat/chatbinding.dart';
import '../../view/message/chat/chatpage.dart';
import '../../view/signin/signinbinding.dart';
import '../../view/signin/signinpage.dart';
import '../../view/signup/signupbinding.dart';
import '../../view/signup/signuppage.dart';
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
        middlewares: [
          RouteWelcomeMiddleware(priority: 1),
        ]),

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
    GetPage(
      name: AppRoutes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
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
        transition: Transition.downToUp),
    GetPage(
      name: AppRoutes.Exercise,
      page: () => ExercisePage(),
      binding: ExerciseBinding(),
    ),
    GetPage(
        name: AppRoutes.Contact,
        page: () => ContactPage(),
        binding: ContactBinding()),
    GetPage(
        name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),
    // GetPage(
    //   name: AppRoutes.ChatBot,
    //   page: () => ChatbotPage(),
    //   binding: ChatbotBinding(),
    // )
    // GetPage(
    //     name: AppRoutes.Contact,
    //     page: () => FoodsPage(),
    //     binding: FoodsBinding()),
  ];
}
