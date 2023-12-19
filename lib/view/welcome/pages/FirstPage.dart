// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

class FirstPage extends StatelessWidget {
  final VoidCallback onTap;
  const FirstPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: AppColors.brand09,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 400.h,
            child: Image.asset("assets/images/healthy_lifestyle.png"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 30.0.w, left: 30.0.w),
                    child: const Column(children: [
                      Text(
                        "MyDiet\na new way of healthy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.brand02,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Wrap(children: [
                        Text(
                          "Quickly and easily track your diet progress every day.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.brand05,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 40.0,
                      )
                    ]),
                  ),
                  Container(
                    height: 50.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              onTap();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brand04,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: const Text(
                              'Ready to start',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          )
        ],
      ),
    ));
  }
}
