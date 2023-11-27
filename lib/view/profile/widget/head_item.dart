import 'package:flutter/material.dart';
import 'package:my_diet/common/entities/user.dart';
import 'package:my_diet/common/style/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_diet/common/widgets/image.dart';

Widget HeadItem(UserLoginResponseEntity item) {
  return Container(
    padding: EdgeInsets.only(top: 30.w, left: 15.w, right: 15.w, bottom: 15.w),
    margin: EdgeInsets.only(bottom: 30.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      boxShadow: const [
        BoxShadow(
            color: AppColor.borderColor,
            offset: Offset(0.0, 5.0),
            blurRadius: 15.0,
            spreadRadius: 1.0)
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 54.w,
                  height: 54.w,
                  /*child: netImageCached(
                    item.photoUrl ?? "",
                    width: 54.w,
                    height: 54.w,
                  ),*/
                ))
          ],
        ),
        SizedBox(
          width: 250.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 5.2, left: 15.w, right: 0.w, bottom: 0.w),
                alignment: Alignment.centerLeft,
                width: 190.w,
                height: 54.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.displayName ?? "",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Avenir',
                          color: AppColor.primaryText),
                    ),
                    Text(
                      "ID: ${item.accessToken ?? ""}",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Avenir',
                          color: AppColor.secondaryColor),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
