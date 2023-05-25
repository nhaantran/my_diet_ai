import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';

class AppIntroduction extends StatelessWidget {
  const AppIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
                width: 128.w,
                height: 128.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset("assets/icons/logo_my_diet.png",
                      fit: BoxFit.fill, width: 128.w, height: 120.h),
                )),
            SizedBox(height: 20.0.h),
            RichText(
              text: const TextSpan(
                  style: TextStyle(fontFamily: "Gothic"),
                  children: <TextSpan>[
                    TextSpan(
                        text: " M",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                        text: "y",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                        text: "D",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                        text: "i",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                        text: "e",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                        text: "t ",
                        style: TextStyle(
                          color: AppColors.brand05,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        )),
                  ]),
            ),
            SizedBox(height: 10.0.h),
            const Text("A platform built for a smart way of managing health",
                style: TextStyle(
                  color: AppColors.fontDark,
                  fontFamily: "Gothic",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                )),
            SizedBox(height: 30.0.h),
           
          ],
        ),
      );
  }
}