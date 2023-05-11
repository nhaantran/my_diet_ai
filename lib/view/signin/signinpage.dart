import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/common/values/colors.dart';
import 'package:my_diet/view/signin/signincontroller.dart';

// void main() {
//   runApp(SignUpApp());
// }

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              
              controller.handleSignIn();
            },
            child: Text("Google sign-in"))
      ],
    )));
  }
}

class SignIn extends GetView<SignInController> {
  //const SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 70.0, left: 30.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                        text: "Hello",
                        style: TextStyle(
                            fontSize: 26,
                            color: AppColors.fontDark,
                            fontWeight: FontWeight.w900))),
                RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                        text: "Lorem asdl ooalls ",
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColors.fontDark,
                            fontWeight: FontWeight.w400))),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    controller.handleSignIn();
                    if (_formKey.currentState!.validate()) {
                      // Perform sign-up logic here
                      // You can access the entered values using:
                      // _usernameController.text
                      // _passwordController.text
                      // _confirmPasswordController.text
                    }
                  },
                  child: Text('Sign Up'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: AppColors.brand05)))),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.fontDark,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: "Sign in ",
                      onEnter: (event) {},
                      style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.brand05,
                          fontWeight: FontWeight.w400))
                ],
              )),
        ),
      ],
    ));
  }
}
