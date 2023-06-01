import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/common/values/colors.dart';
import 'package:my_diet/view/common_widgets/AppIntroduction.dart';
import 'package:my_diet/view/signin/signincontroller.dart';

// void main() {
//   runApp(SignUpApp());
// }

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppIntroduction(),
          signIn(),
        ],
      ),
    );
  }
}

//     Scaffold(
//         body: Center(
//             child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//             onPressed: () {

//               controller.handleSignIn();
//             },
//             child: Text("Google sign-in"))
//       ],
//     )));
//   }
// }

class signIn extends GetView<SignInController> {
  final signInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: signInKey,
      child: Padding(
        padding: EdgeInsets.only(right: 10.0.w, left: 10.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "User Email",
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
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: AppColors.brand05,
                  ),
                  onPressed: () {},
                ),
                labelText: "Password",
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: AppColors.brand05),
                    borderRadius: BorderRadius.circular(20.0) //<-- SEE HERE
                    ),
              ),
            ),
            SizedBox(height: 10.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
            SizedBox(height: 10.0.h),
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
                            side: const BorderSide(color: AppColors.brand06)))),
                onPressed: () {
                  //controller.handleSignIn();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20.0.h),
            const Text(
              "Or",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "OpenSans",
                  color: AppColors.fontMid),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 40.h,
              width: double.infinity,
              child: OutlinedButton.icon(
                  onPressed: () => controller.handleSignIn(),
                  icon: Image.asset("assets/icons/google.png"),
                  label: const Text(
                    'Sign In with Google',
                    style: TextStyle(
                        color: AppColors.brand05, fontFamily: "OpenSans"),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.purple),
                    borderRadius: BorderRadius.circular(10.0),
                  )))),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? ",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: AppColors.fontDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                TextButton(
                    onPressed: () {
                      controller.moveToSignUp();
                    },
                    child: const Text(
                      "Sign up",
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
