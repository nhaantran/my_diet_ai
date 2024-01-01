import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/welcome/pages/ActiveWelcomePage.dart';
import 'package:my_diet/view/welcome/pages/AgeWelcomePage.dart';
import 'package:my_diet/view/welcome/pages/CurrentWeightWelcomePage.dart';
import 'package:my_diet/view/welcome/pages/FirstPage.dart';
import 'package:my_diet/view/welcome/pages/GenderWelcomePage.dart';
import 'package:my_diet/view/welcome/pages/GoalWelcomePage.dart';
import 'package:my_diet/view/welcome/pages/HeightWelcomePage.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../common/values/colors.dart';
import '../common_widgets/KeepAlivePage.dart';
import 'pages/TargetWeightWelcomePage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(alignment: Alignment.topCenter, children: [
              _buildPageView(),
              _buildDotIndicator(),
            ]),
          )),
    );
  }
}

class _buildDotIndicator extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Positioned(
        top: 50,
        width: 120.w,
        height: 10.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 10,
            child: LinearPercentIndicator(
              lineHeight: 8.h,
              backgroundColor: AppColors.brand08,
              progressColor: AppColors.brand03,
              percent: controller.progressValue.value,
              animateFromLastPercent: true,
              barRadius: const Radius.circular(10),
              animation: true,
              restartAnimation: false,
            ),
          ),
        )));
  }
}

// LinearProgressIndicator(
//               value: controller.progressValue.value, // percent filled
//               valueColor: Animation<Color>(AppColors.brand03),
//               backgroundColor: AppColors.brand08,
//             ),
class _buildPageView extends GetView<WelcomeController> {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 1);
  int currentPageIndex = 0;

  movingNextPage(PageController pageController, int currentPageIndex) {
    print(currentPageIndex);
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentPageIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  movingPreviousPage(PageController pageController, int currentPageIndex) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentPageIndex - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInBack,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView(
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) => {
        controller.changePage(index),
      },
      controller: pageController,
      pageSnapping: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        FirstPage(onTap: () {
          currentPageIndex = pageController.page!.round();
          movingNextPage(pageController, currentPageIndex);
        }),
        KeepAlivePage(
            child: GoalWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () {
            currentPageIndex = pageController.page!.round();

            movingNextPage(pageController, currentPageIndex);
          },
        )),
        KeepAlivePage(
            child: GenderWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () {
            currentPageIndex = pageController.page!.round();
            movingNextPage(pageController, currentPageIndex);
          },
        )),
        KeepAlivePage(
            child: AgeWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () {
            currentPageIndex = pageController.page!.round();
            movingNextPage(pageController, currentPageIndex);
          },
        )),
        KeepAlivePage(
            child: HeightWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () {
            currentPageIndex = pageController.page!.round();
            movingNextPage(pageController, currentPageIndex);
          },
        )),
        KeepAlivePage(
            child: CurrentWeightWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () {
            currentPageIndex = pageController.page!.round();
            movingNextPage(pageController, currentPageIndex);
          },
        )),
        KeepAlivePage(
            child: TargetWeightWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () {
            currentPageIndex = pageController.page!.round();
            movingNextPage(pageController, currentPageIndex);
          },
        )),
        KeepAlivePage(
            child: ActiveWelcomePage(
          back: () {
            currentPageIndex = pageController.page!.round();
            movingPreviousPage(pageController, currentPageIndex);
          },
          onTap: () async {
            // print("current: " + currentPageIndex.toString());
            // currentPageIndex = pageController.page!.round();
            controller.handleSignIn();
            //movingNextPage(pageController, currentPageIndex);
          },
        )),
        // Container(
        //     width: double.infinity,
        //     height: double.infinity,
        //     child: Stack(
        //       alignment: Alignment.bottomCenter,
        //       children: [
        //         Positioned(
        //           bottom: 90,
        //           child: Column(children: [
        //             Text("qweqweqweqweqwe.\nqweqwe.\nqweqwe"),
        //             ElevatedButton(
        //               onPressed: () {

        //               },
        //               style: ButtonStyle(
        //                 backgroundColor:
        //                     MaterialStateProperty.all(Colors.white),
        //                 foregroundColor:
        //                     MaterialStateProperty.all(Colors.black),
        //                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(15))),
        //               ),
        //               child: Text("Log in"),
        //             )
        //           ]),
        //         )
        //       ],
        //     )),
      ],
    );
  }
}

//   Container firstPage(VoidCallback onTap) {
//     return Container(
//         color: AppColors.monochromatic09,
//         width: double.infinity,
//         height: double.infinity,
//         // decoration: const BoxDecoration(
//         //     image: DecorationImage(
//         //         image: AssetImage("assets/images/gym.jpg"),
//         //         fit: BoxFit.fill)),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "What's your goal?",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 24,
//                     fontFamily: 'Gothic',
//                     fontWeight: FontWeight.w900),
//               ),
//               // currentPageIndex = _pageController.page!.round();
//               //     movingNextPage(_pageController, currentPageIndex);
//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Container(child: Text("helo")),
//                 ),
//               ),
//               SimpleButtonCard(
//                 iconAssets: AssetImage("assets/icons/stayhealthy.png"),
//                 buttonText: "Stay Healthy",
//                 onTap: onTap
//                 // currentPageIndex = _pageController.page!.round();
//                 // movingNextPage(_pageController, currentPageIndex);
//                 ,
//               )
//               // SimpleButtonCard(
//               //   onTap: () {
//               //     currentPageIndex = _pageController.page!.round();
//               //     movingNextPage(_pageController, currentPageIndex);
//               //   },
//               //   iconAssets: AssetImage("assets/icons/stayhealthy.png"),
//               //   buttonText: "Stay Healthy",
//               // ),
//               // SimpleButtonCard(
//               //   onTap: () {
//               //     currentPageIndex = _pageController.page!.round();
//               //     movingNextPage(_pageController, currentPageIndex);
//               //   },
//               //   iconAssets: AssetImage("assets/icons/gainweight.png"),
//               //   buttonText: "Gain Weight",
//               // ),
//             ],
//           ),
//         ));
//   }

















// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:my_diet/view/common_widgets/KeepAlivePage.dart';
// import 'package:my_diet/view/common_widgets/SimpleButtonCard.dart';
// import 'package:my_diet/view/welcome/welcomecontroller.dart';

// import '../../common/values/colors.dart';
// import 'widgets/WelcomeCard.dart';

// // class WelcomePage extends StatefulWidget {
// //   const WelcomePage({super.key});

// //   @override
// //   State<WelcomePage> createState() => _WelcomePageState();
// // }

// // class _WelcomePageState extends State<WelcomePage> {
// //   final PageController _pageController =
// //       PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
// //   int currentPageIndex = 1;

// //   movingNextPage(PageController pageController, int currentPageIndex) {
// //     //final controller = Get.find<ButtonController>();
// //     //controller.onTap();
// //     if (pageController.hasClients) {
// //       pageController.animateToPage(
// //         currentPageIndex + 1,
// //         duration: const Duration(milliseconds: 500),
// //         curve: Curves.easeInOut,
// //       );
// //     }
// //   }

// //   final WelcomeController controller = new WelcomeController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return PageView(
// //       scrollDirection: Axis.horizontal,
// //       reverse: false,
// //       onPageChanged: (index) => {controller.changePage(index)},
// //       controller: _pageController,
// //       //pageSnapping: true,
// //       //physics: const ClampingScrollPhysics(),
// //       children: [
// //         KeepAlivePage(
// //             child:
// //                 firstPage(movingNextPage(_pageController, currentPageIndex))),
// //         firstPage(movingNextPage(_pageController, currentPageIndex)),
// //         // secondPage(currentPageIndex, _pageController),
// //         // thirdPage(currentPageIndex, _pageController),
// //         // fourthPage(currentPageIndex, _pageController),
// //         // fifthPage(currentPageIndex, _pageController),
// //         // sixthPage(currentPageIndex, _pageController),
// //         // seventhPage(currentPageIndex, _pageController),
// //         // eigthPage(currentPageIndex, _pageController),
// //         //conclusionPage(),
// //         Container(
// //             width: double.infinity,
// //             height: double.infinity,
// //             child: Stack(
// //               alignment: Alignment.bottomCenter,
// //               children: [
// //                 Positioned(
// //                   bottom: 90,
// //                   child: Column(children: [
// //                     Text("qweqweqweqweqwe.\nqweqwe.\nqweqwe"),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         controller.handleSignIn();
// //                       },
// //                       style: ButtonStyle(
// //                         backgroundColor:
// //                             MaterialStateProperty.all(Colors.white),
// //                         foregroundColor:
// //                             MaterialStateProperty.all(Colors.black),
// //                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(15))),
// //                       ),
// //                       child: Text("Log in"),
// //                     )
// //                   ]),
// //                 )
// //               ],
// //             )),
// //       ],
// //     );
// //   }
// // }// //     return PageView(
// //       scrollDirection: Axis.horizontal,
// //       reverse: false,
// //       onPageChanged: (index) => {controller.changePage(index)},
// //       controller: _pageController,
// //       //pageSnapping: true,
// //       //physics: const ClampingScrollPhysics(),
// //       children: [
// //         KeepAlivePage(
// //             child:
// //                 firstPage(movingNextPage(_pageController, currentPageIndex))),
// //         firstPage(movingNextPage(_pageController, currentPageIndex)),
// //         // secondPage(currentPageIndex, _pageController),
// //         // thirdPage(currentPageIndex, _pageController),
// //         // fourthPage(currentPageIndex, _pageController),
// //         // fifthPage(currentPageIndex, _pageController),
// //         // sixthPage(currentPageIndex, _pageController),
// //         // seventhPage(currentPageIndex, _pageController),
// //         // eigthPage(currentPageIndex, _pageController),
// //         //conclusionPage(),
// //         Container(
// //             width: double.infinity,
// //             height: double.infinity,
// //             child: Stack(
// //               alignment: Alignment.bottomCenter,
// //               children: [
// //                 Positioned(
// //                   bottom: 90,
// //                   child: Column(children: [
// //                     Text("qweqweqweqweqwe.\nqweqwe.\nqweqwe"),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         controller.handleSignIn();
// //                       },
// //                       style: ButtonStyle(
// //                         backgroundColor:
// //                             MaterialStateProperty.all(Colors.white),
// //                         foregroundColor:
// //                             MaterialStateProperty.all(Colors.black),
// //                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(15))),
// //                       ),
// //                       child: Text("Log in"),
// //                     )
// //                   ]),
// //                 )
// //               ],
// //             )),
// //       ],
// //     );
// //   }
// // }

// // Container firstPage(Function onTap) {
// //   return Container(
// //       color: AppColors.monochromatic09,
// //       width: double.infinity,
// //       height: double.infinity,
// //       // decoration: const BoxDecoration(
// //       //     image: DecorationImage(
// //       //         image: AssetImage("assets/images/gym.jpg"),
// //       //         fit: BoxFit.fill)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Text(
// //               "What's your goal?",
// //               style: TextStyle(
// //                   color: Colors.black,
// //                   fontSize: 24,
// //                   fontFamily: 'Gothic',
// //                   fontWeight: FontWeight.w900),
// //             ),
// //             // currentPageIndex = _pageController.page!.round();
// //             //     movingNextPage(_pageController, currentPageIndex);
// //             Card(
// //               child: Padding(
// //                 padding: EdgeInsets.all(10.0),
// //                 child: Container(child: Text("helo")),
// //               ),
// //             ),
// //             SimpleButtonCard(
// //               iconAssets: AssetImage("assets/icons/stayhealthy.png"),
// //               buttonText: "Stay Healthy",
// //               onTap: () =>
// //                 onTap()
// //                 // currentPageIndex = _pageController.page!.round();
// //                 // movingNextPage(_pageController, currentPageIndex);
// //               ,
// //             )
// //             // SimpleButtonCard(
// //             //   onTap: () {
// //             //     currentPageIndex = _pageController.page!.round();
// //             //     movingNextPage(_pageController, currentPageIndex);
// //             //   },
// //             //   iconAssets: AssetImage("assets/icons/stayhealthy.png"),
// //             //   buttonText: "Stay Healthy",
// //             // ),
// //             // SimpleButtonCard(
// //             //   onTap: () {
// //             //     currentPageIndex = _pageController.page!.round();
// //             //     movingNextPage(_pageController, currentPageIndex);
// //             //   },
// //             //   iconAssets: AssetImage("assets/icons/gainweight.png"),
// //             //   buttonText: "Gain Weight",
// //             // ),
// //           ],
// //         ),
// //       ));
// // }

// class WelcomePage extends GetView<WelcomeController> {
//   const WelcomePage({super.key});

//   movingNextPage(PageController pageController, int currentPageIndex) {
//     //final controller = Get.find<ButtonController>();
//     //controller.onTap();
//     pageController.animateToPage(
//       currentPageIndex + 1,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   // final List<Widget> _pages = (int currentPageIndex, PageController _pageController )[
//   //    firstPage(currentPageIndex, _pageController),
//   //       secondPage(currentPageIndex, _pageController),
//   //       thirdPage(currentPageIndex, _pageController),
//   //       fourthPage(currentPageIndex, _pageController),
//   //       fifthPage(currentPageIndex, _pageController),
//   //       sixthPage(currentPageIndex, _pageController),
//   //       seventhPage(currentPageIndex, _pageController)
//   //  ];

//   Widget _buildPageView(BuildContext context) {
//     final PageController _pageController =
//         PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
//     int currentPageIndex = 1;

//     return PageView(
//       scrollDirection: Axis.horizontal,
//       reverse: false,
//       onPageChanged: (index) => {controller.changePage(index)},
//       controller: _pageController,
//       //pageSnapping: true,
//       //physics: const ClampingScrollPhysics(),
//       children: [
//         KeepAlivePage(child: firstPage(currentPageIndex, _pageController)),
//         firstPage(currentPageIndex, _pageController),
//         // secondPage(currentPageIndex, _pageController),
//         // thirdPage(currentPageIndex, _pageController),
//         // fourthPage(currentPageIndex, _pageController),
//         // fifthPage(currentPageIndex, _pageController),
//         // sixthPage(currentPageIndex, _pageController),
//         // seventhPage(currentPageIndex, _pageController),
//         // eigthPage(currentPageIndex, _pageController),
//         //conclusionPage(),
//         Container(
//             width: double.infinity,
//             height: double.infinity,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Positioned(
//                   bottom: 90,
//                   child: Column(children: [
//                     Text("qweqweqweqweqwe.\nqweqwe.\nqweqwe"),
//                     ElevatedButton(
//                       onPressed: () {
//                         controller.handleSignIn();
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.white),
//                         foregroundColor:
//                             MaterialStateProperty.all(Colors.black),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                       ),
//                       child: Text("Log in"),
//                     )
//                   ]),
//                 )
//               ],
//             )),
//       ],
//     );
//   }

//   Container firstPage(int currentPageIndex, PageController _pageController) {
//     int index;

//     return Container(
//         color: AppColors.monochromatic09,
//         width: double.infinity,
//         height: double.infinity,
//         // decoration: const BoxDecoration(
//         //     image: DecorationImage(
//         //         image: AssetImage("assets/images/gym.jpg"),
//         //         fit: BoxFit.fill)),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "What's your goal?",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 24,
//                     fontFamily: 'Gothic',
//                     fontWeight: FontWeight.w900),
//               ),
//               // currentPageIndex = _pageController.page!.round();
//               //     movingNextPage(_pageController, currentPageIndex);
//               Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Container(child: Text("helo")),
//                 ),
//               ),
//               SimpleButtonCard(
//                 iconAssets: AssetImage("assets/icons/stayhealthy.png"),
//                 buttonText: "Stay Healthy",
//                 onTap: () {
//                   currentPageIndex = _pageController.page!.round();
//                   movingNextPage(_pageController, currentPageIndex);
//                 },
//               )
//               // SimpleButtonCard(
//               //   onTap: () {
//               //     currentPageIndex = _pageController.page!.round();
//               //     movingNextPage(_pageController, currentPageIndex);
//               //   },
//               //   iconAssets: AssetImage("assets/icons/stayhealthy.png"),
//               //   buttonText: "Stay Healthy",
//               // ),
//               // SimpleButtonCard(
//               //   onTap: () {
//               //     currentPageIndex = _pageController.page!.round();
//               //     movingNextPage(_pageController, currentPageIndex);
//               //   },
//               //   iconAssets: AssetImage("assets/icons/gainweight.png"),
//               //   buttonText: "Gain Weight",
//               // ),
//             ],
//           ),
//         ));
//   }

//   // Container secondPage(int currentPageIndex, PageController _pageController) {
//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "Which gender were\nyou assigned at birth?",
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           SimpleButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //               print("Helo");
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/female.png"),
//   //             buttonText: "Female",
//   //           ),
//   //           SimpleButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             iconAssets: AssetImage("assets/icons/male.png"),
//   //             buttonText: "Male",
//   //           ),
//   //         ],
//   //       ));
//   // }

//   // Container thirdPage(int currentPageIndex, PageController _pageController) {
//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "How old are you?",
//   //             textAlign: TextAlign.center,
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           Padding(
//   //             padding: EdgeInsets.all(30.0),
//   //             child: TextField(
//   //               onEditingComplete: () {
//   //                 currentPageIndex = _pageController.page!.round();
//   //                 movingNextPage(_pageController, currentPageIndex);
//   //               },
//   //               decoration: InputDecoration(
//   //                 enabledBorder: OutlineInputBorder(
//   //                     borderSide:
//   //                         const BorderSide(width: 3, color: AppColors.brand05),
//   //                     borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
//   //                     ),
//   //               ),
//   //             ),
//   //           )
//   //         ],
//   //       ));
//   // }

//   // Container fourthPage(int currentPageIndex, PageController _pageController) {
//   //   final RulerPickerController? _rulerPickerController =
//   //       RulerPickerController(value: 150);

//   //   Widget _buildBtn(int begin, int value, int end, String dimensions) {
//   //     return Material(
//   //       elevation: 5.0,
//   //       borderRadius: BorderRadius.circular(50.0),
//   //       child: InkWell(
//   //         onTap: () {
//   //           controller.changeHeight(begin, value, end);
//   //         },
//   //         child: Container(
//   //             alignment: Alignment.center,
//   //             height: 35.h,
//   //             width: 60.w,
//   //             padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//   //             decoration: BoxDecoration(
//   //               color: AppColors.brand05,
//   //               borderRadius: BorderRadius.circular(20.0),
//   //             ),
//   //             child: Text(
//   //               dimensions,
//   //               style: TextStyle(color: Colors.white, fontSize: 15),
//   //             )),
//   //       ),
//   //     );
//   //   }

//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "How tall are you?",
//   //             textAlign: TextAlign.center,
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           Padding(
//   //             padding: EdgeInsets.all(20.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 Padding(
//   //                   padding: EdgeInsets.all(5.0),
//   //                   child: _buildBtn(100, 150, 200, "cm"),
//   //                 ),
//   //                 // Padding(
//   //                 //   padding: EdgeInsets.all(5.0),
//   //                 //   child: _buildBtn(3.5, 4.6, 6.0, "ft"),
//   //                 // )
//   //               ],
//   //             ),
//   //           ),
//   //           Padding(
//   //               padding: EdgeInsets.all(0.0),
//   //               child: Obx(
//   //                 () => RulerPicker(
//   //                   controller: _rulerPickerController!,
//   //                   beginValue: controller.beginHeight.value,
//   //                   endValue: controller.endHeight.value,
//   //                   initValue: controller.height.value,
//   //                   onBuildRulerScalueText: (index, scaleValue) {
//   //                     return scaleValue.toString();
//   //                   },
//   //                   scaleLineStyleList: const [
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 2,
//   //                         height: 40,
//   //                         scale: 0),
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 1,
//   //                         height: 25,
//   //                         scale: 5),
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 0,
//   //                         height: 0,
//   //                         scale: -1),
//   //                   ],
//   //                   onValueChange: (value) => {
//   //                     controller.changeHeight(controller.beginHeight.value,
//   //                         value, controller.endHeight.value)
//   //                   },
//   //                   width: 400,
//   //                   height: 100,
//   //                   rulerMarginTop: 8,
//   //                   marker: Container(
//   //                       width: 8,
//   //                       height: 50,
//   //                       decoration: BoxDecoration(
//   //                           color: AppColors.brand05.withOpacity(0.7),
//   //                           borderRadius: BorderRadius.circular(5))),
//   //                 ),
//   //               )),
//   //           Text(
//   //             controller.height.toString() + " cm",
//   //             style: TextStyle(
//   //                 color: AppColors.brand03,
//   //                 fontWeight: FontWeight.bold,
//   //                 fontSize: 60),
//   //           ),
//   //         ],
//   //       ));
//   // }

//   // Container fifthPage(int currentPageIndex, PageController _pageController) {
//   //   final RulerPickerController? _rulerPickerController =
//   //       RulerPickerController(value: 150);

//   //   Widget _buildBtn(int begin, int value, int end, String dimensions) {
//   //     return Material(
//   //       elevation: 5.0,
//   //       borderRadius: BorderRadius.circular(50.0),
//   //       child: InkWell(
//   //         onTap: () {
//   //           controller.changeHeight(begin, value, end);
//   //         },
//   //         child: Container(
//   //             alignment: Alignment.center,
//   //             height: 35.h,
//   //             width: 60.w,
//   //             padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//   //             decoration: BoxDecoration(
//   //               color: AppColors.brand05,
//   //               borderRadius: BorderRadius.circular(20.0),
//   //             ),
//   //             child: Text(
//   //               dimensions,
//   //               style: TextStyle(color: Colors.white, fontSize: 15),
//   //             )),
//   //       ),
//   //     );
//   //   }

//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "What's your weight?",
//   //             textAlign: TextAlign.center,
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           Padding(
//   //             padding: EdgeInsets.all(20.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 Padding(
//   //                   padding: EdgeInsets.all(5.0),
//   //                   child: _buildBtn(100, 150, 200, "cm"),
//   //                 ),
//   //                 // Padding(
//   //                 //   padding: EdgeInsets.all(5.0),
//   //                 //   child: _buildBtn(3.5, 4.6, 6.0, "ft"),
//   //                 // )
//   //               ],
//   //             ),
//   //           ),
//   //           Padding(
//   //               padding: EdgeInsets.all(0.0),
//   //               child: Obx(
//   //                 () => RulerPicker(
//   //                   controller: _rulerPickerController!,
//   //                   beginValue: 300,
//   //                   endValue: 1200,
//   //                   initValue: controller.height.value,
//   //                   onBuildRulerScalueText: (index, scaleValue) {
//   //                     int digit = scaleValue > 1000
//   //                         ? scaleValue % 1000
//   //                         : scaleValue % 100;

//   //                     return "${scaleValue / 100}";
//   //                   },
//   //                   scaleLineStyleList: const [
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 2,
//   //                         height: 40,
//   //                         scale: 0),
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 1,
//   //                         height: 25,
//   //                         scale: 5),
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 0,
//   //                         height: 0,
//   //                         scale: -1),
//   //                   ],
//   //                   onValueChange: (value) => {controller.changeWeight(value)},
//   //                   width: 400,
//   //                   height: 100,
//   //                   rulerMarginTop: 8,
//   //                   marker: Container(
//   //                       width: 8,
//   //                       height: 50,
//   //                       decoration: BoxDecoration(
//   //                           color: AppColors.brand05.withOpacity(0.7),
//   //                           borderRadius: BorderRadius.circular(5))),
//   //                 ),
//   //               )),
//   //           Text(
//   //             "${(controller.weight / 100).toString()} cm",
//   //             style: TextStyle(
//   //                 color: AppColors.brand03,
//   //                 fontWeight: FontWeight.bold,
//   //                 fontSize: 60),
//   //           ),
//   //         ],
//   //       ));
//   // }

//   // Container sixthPage(int currentPageIndex, PageController _pageController) {
//   //   final RulerPickerController? _rulerPickerController =
//   //       RulerPickerController(value: 150);

//   //   Widget _buildBtn(int begin, int value, int end, String dimensions) {
//   //     return Material(
//   //       elevation: 5.0,
//   //       borderRadius: BorderRadius.circular(50.0),
//   //       child: InkWell(
//   //         onTap: () {
//   //           controller.changeHeight(begin, value, end);
//   //         },
//   //         child: Container(
//   //             alignment: Alignment.center,
//   //             height: 35.h,
//   //             width: 60.w,
//   //             padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//   //             decoration: BoxDecoration(
//   //               color: AppColors.brand05,
//   //               borderRadius: BorderRadius.circular(20.0),
//   //             ),
//   //             child: Text(
//   //               dimensions,
//   //               style: TextStyle(color: Colors.white, fontSize: 15),
//   //             )),
//   //       ),
//   //     );
//   //   }

//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "What's your goal weight?",
//   //             textAlign: TextAlign.center,
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           Padding(
//   //             padding: EdgeInsets.all(20.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 Padding(
//   //                   padding: EdgeInsets.all(5.0),
//   //                   child: _buildBtn(100, 150, 200, "cm"),
//   //                 ),
//   //                 // Padding(
//   //                 //   padding: EdgeInsets.all(5.0),
//   //                 //   child: _buildBtn(3.5, 4.6, 6.0, "ft"),
//   //                 // )
//   //               ],
//   //             ),
//   //           ),
//   //           Padding(
//   //               padding: EdgeInsets.all(0.0),
//   //               child: Obx(
//   //                 () => RulerPicker(
//   //                   rulerBackgroundColor: AppColors.brand07.withOpacity(0.3),
//   //                   controller: _rulerPickerController!,
//   //                   beginValue: 300,
//   //                   endValue: 1200,
//   //                   initValue: controller.height.value,
//   //                   onBuildRulerScalueText: (index, scaleValue) {
//   //                     int digit = scaleValue > 1000
//   //                         ? scaleValue % 1000
//   //                         : scaleValue % 100;

//   //                     return "${scaleValue / 100}";
//   //                   },
//   //                   scaleLineStyleList: const [
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 2,
//   //                         height: 40,
//   //                         scale: 0),
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 1,
//   //                         height: 25,
//   //                         scale: 5),
//   //                     ScaleLineStyle(
//   //                         color: AppColors.brand07,
//   //                         width: 0,
//   //                         height: 0,
//   //                         scale: -1),
//   //                   ],
//   //                   onValueChange: (value) => {controller.changeWeight(value)},
//   //                   width: 400,
//   //                   height: 100,
//   //                   rulerMarginTop: 8,
//   //                   marker: Container(
//   //                       width: 8,
//   //                       height: 50,
//   //                       decoration: BoxDecoration(
//   //                           color: AppColors.brand05.withOpacity(0.7),
//   //                           borderRadius: BorderRadius.circular(5))),
//   //                 ),
//   //               )),
//   //           Text(
//   //             "${(controller.weight / 100).toString()} cm",
//   //             style: TextStyle(
//   //                 color: AppColors.brand03,
//   //                 fontWeight: FontWeight.bold,
//   //                 fontSize: 60),
//   //           ),
//   //         ],
//   //       ));
//   // }

//   // Container seventhPage(int currentPageIndex, PageController _pageController) {
//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "How active are you?",
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           // currentPageIndex = _pageController.page!.round();
//   //           //     movingNextPage(_pageController, currentPageIndex);
//   //           ComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/sedentary.png"),
//   //             title: "Not very active",
//   //             description: "I have a sedentary lifestyle.",
//   //             example: "E.g. desk job, bank teller",
//   //           ),
//   //           ComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/moderately_active.png"),
//   //             title: "Moderately active",
//   //             description: "I spend a good part of the day on my feet.",
//   //             example: "E.g teacher, salesperson",
//   //           ),
//   //           ComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/active.png"),
//   //             title: "Active",
//   //             description:
//   //                 "I spend a good part of the day walking or doing some physical activity.",
//   //             example: "E.g waiter, nurse",
//   //           ),
//   //           ComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/very_active.png"),
//   //             title: "Very active",
//   //             description:
//   //                 "I spend most of the day doing heavy physical work or activity.",
//   //             example: "E.g carpenter, construction worker",
//   //           ),
//   //         ],
//   //       ));
//   // }

//   // Container eigthPage(int currentPageIndex, PageController _pageController) {
//   //   return Container(
//   //       color: AppColors.monochromatic09,
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       // decoration: const BoxDecoration(
//   //       //     image: DecorationImage(
//   //       //         image: AssetImage("assets/images/gym.jpg"),
//   //       //         fit: BoxFit.fill)),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Text(
//   //             "Choose the intensity",
//   //             style: TextStyle(
//   //                 color: Colors.black,
//   //                 fontSize: 24,
//   //                 fontFamily: 'Gothic',
//   //                 fontWeight: FontWeight.w900),
//   //           ),
//   //           // currentPageIndex = _pageController.page!.round();
//   //           //     movingNextPage(_pageController, currentPageIndex);
//   //           VeryComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/ultimate.png"),
//   //             title: "Ultimate",
//   //             description: "I have a sedentary lifestyle.",
//   //             example: "E.g. desk job, bank teller",
//   //             difficulty: 3,
//   //             duration: '20',
//   //             percentage: 77,
//   //             weightLoss: 0.51,
//   //           ),
//   //           VeryComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/steady.png"),
//   //             title: "Steady",
//   //             description: "I have a sedentary lifestyle.",
//   //             example: "E.g. desk job, bank teller",
//   //             difficulty: 3,
//   //             duration: '20',
//   //             percentage: 77,
//   //             weightLoss: 0.51,
//   //           ),
//   //           VeryComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/gradual.png"),
//   //             title: "Gradual",
//   //             description: "I have a sedentary lifestyle.",
//   //             example: "E.g. desk job, bank teller",
//   //             difficulty: 3,
//   //             duration: '20',
//   //             percentage: 77,
//   //             weightLoss: 0.51,
//   //           ),

//   //           VeryComplexButtonCard(
//   //             onTap: () {
//   //               currentPageIndex = _pageController.page!.round();
//   //               movingNextPage(_pageController, currentPageIndex);
//   //             },
//   //             index: currentPageIndex,
//   //             iconAssets: AssetImage("assets/icons/relax.png"),
//   //             title: "Relax",
//   //             description: "I have a sedentary lifestyle.",
//   //             example: "E.g. desk job, bank teller",
//   //             difficulty: 3,
//   //             duration: '20',
//   //             percentage: 77,
//   //             weightLoss: 0.51,
//   //           ),
//   //         ],
//   //       ));
//   // }

//   Widget _buildDotIndicator() {
//     return Positioned(
//         bottom: 50,
//         child: DotsIndicator(
//           position: controller.index.value,
//           dotsCount: 10,
//           reversed: false,
//           mainAxisAlignment: MainAxisAlignment.center,
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Obx(() => SizedBox(
//               width: 360.w,
//               height: 780.w,
//               child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [_buildPageView(context), _buildDotIndicator()]),
//             )));
//   }
// }
