import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../common/values/colors.dart';

class ContentRow extends StatelessWidget {
  const ContentRow({
    Key? key,
    this.image,
    required this.header,
    required this.description,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String? image;
  final String header;
  final String description;
  final Icon icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            height: 90.0.h,
            width: 320.0.w,
            decoration: BoxDecoration(
              color: AppColors.monochromatic09,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(image ?? "assets/images/null_image.png",
                        fit: BoxFit.fill, width: 76.w, height: 76.h),
                    //CachedNetworkImage(imageUrl: "${item.photourl}"),
                  ),
                ),
                // Container(
                //   height: 72.0.w,
                //   width: 72.0.w,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(image: image, fit: BoxFit.fill)),
                //   child: SizedBox(
                //     width: 72.w,
                //     height: 72.w,
                //   ),
                // ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                            color: AppColors.fontDark,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                            color: AppColors.fontMid,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  height: 16.0.w,
                  width: 16.0.w,
                  child: IconButton(
                    icon: icon,
                    onPressed: () {
                      onTap();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
