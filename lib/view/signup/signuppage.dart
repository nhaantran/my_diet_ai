import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_diet/view/common_widgets/AppIntroduction.dart';
import 'package:my_diet/view/signup/signupcontroller.dart';

import '../../common/values/colors.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppIntroduction(),
          signUp(),
        ],
      ),
    );
  }
}

class signUp extends GetView<SignUpController> {
  final signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpKey,
      child: Padding(
        padding: EdgeInsets.only(right: 10.0.w, left: 10.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: AppColors.brand05),
                    borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                    ),
              ),
            ),
            SizedBox(height: 20.0.h),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Enter your password",
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: AppColors.brand05),
                    borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                    ),
              ),
            ),
            SizedBox(height: 20.0.h),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Repeat your password",
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: AppColors.brand05),
                    borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                    ),
              ),
            ),
            SizedBox(height: 30.0.h),
            SizedBox(
              height: 40.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.brand05),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: AppColors.brand06)))),
                onPressed: () {
                  controller.moveToSignIn();
                },
                child: Text('Sign Up'),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: AppColors.fontDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                TextButton(
                    onPressed: () {
                      controller.moveToSignIn();
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        decoration: TextDecoration.underline,
                        color: AppColors.brand05,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
