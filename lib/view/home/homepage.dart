// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:my_diet/common/values/colors.dart';

import '../../common/entities/user.dart';
import 'homecontroller.dart';

class ChartData {
  ChartData(
    this.x,
    this.y,
    this.color,
  );
  final String x;
  final double y;
  final Color color;
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileCustomer(),
          _caloriesCounter(),
        ],
      ),
    );
  }

  Widget _doughnutChart() {
    final List<ChartData> chartData = [
      ChartData('David', 25, Color.fromRGBO(9, 0, 136, 1)),
      ChartData('Steve', 38, Color.fromRGBO(147, 0, 119, 1)),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfCircularChart(annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            widget: Container(
                child: const Text('62%',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25))))
      ], series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            // Radius of doughnut
            radius: '80%')
      ]),
    );
  }

  Widget _caloriesCounter() {
    return Material(
      elevation: 2,
      color: Colors.white,
      shadowColor: Color(0xffB4BCCB),
      borderRadius: BorderRadius.circular(20),
      child: Container(
          padding: EdgeInsets.all(20.0),
          width: 336.w,
          height: 145.h,
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: const [
                  Text(
                    "Calories",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: AppColors.fontDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Remaining = Goal - Food + Exercise",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: AppColors.fontDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  //_doughnutChart(),
                  Column(
                    children: [
                      const Text(
                        "Base Goal",
                        style: TextStyle(
                            fontFamily: "Gothic",
                            fontSize: 12,
                            color: AppColors.fontMid),
                      ),
                      Text(
                        "${controller.baseGoal}",
                        style: const TextStyle(
                            color: AppColors.brand05,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Base Goal",
                        style: TextStyle(
                            fontFamily: "Gothic",
                            fontSize: 12,
                            color: AppColors.fontMid),
                      ),
                      Text(
                        "${controller.caloriesFood}",
                        style: const TextStyle(
                            color: AppColors.fontDark,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Base Goal",
                        style: TextStyle(
                            fontFamily: "Gothic",
                            fontSize: 12,
                            color: AppColors.fontMid),
                      ),
                      Text(
                        "${controller.caloriesExercise}",
                        style: const TextStyle(
                            color: AppColors.fontDark,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
    // return Container(
    //   margin: EdgeInsets.all(0.0),
    //   color: AppColors.white,
    //   child: Row(children: [
    //     RichText(
    //       text: const TextSpan(
    //         text: "Calories\n",
    //         style: TextStyle(
    //             fontFamily: "OpenSans",
    //             color: AppColors.fontDark,
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     RichText(
    //       text: const TextSpan(
    //         text: "Remaining = Goal - Food + Exercise",
    //         style: TextStyle(
    //             fontFamily: "OpenSans",
    //             color: AppColors.fontDark,
    //             fontSize: 8,
    //             fontWeight: FontWeight.w400),
    //       ),
    //     )
    //   ]),
    // );
  }

  Widget _profileCustomer() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/images/bida.jpg",
                  fit: BoxFit.fill, width: 120, height: 120),
              //CachedNetworkImage(imageUrl: "${item.photourl}"),
            ),
          ),
          Text(
            //"${item.name}",
            "Tran Thanh Nhan",
            style: const TextStyle(
                fontSize: 22,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w800),
          ),
          Text(
            //"${item.name}",
            "Normal member",
            style: const TextStyle(
                color: AppColors.brand05,
                fontSize: 16,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
