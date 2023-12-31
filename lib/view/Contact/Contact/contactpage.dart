import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:my_diet/common/values/colors.dart';
import 'package:my_diet/common/widgets/app.dart';
import 'package:my_diet/view/Contact/Widget/contact_list.dart';
import 'package:my_diet/view/Contact/Contact/contactcontroller.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return transparentAppBar(
          title: Text(
        "Contact",
        style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600),
      ));
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: const ContactList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 176, 106, 231),
        onPressed: () async {
          try {
            dynamic conversationObject = {
              'appId':
                  '16445d8ac152e816d2e1c8e0586d0160f' // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
            };
            dynamic result = await KommunicateFlutterPlugin.buildConversation(
                conversationObject);
            print("Conversation builder success : " + result.toString());
          } on Exception catch (e) {
            print("Conversation builder error occurred : " + e.toString());
          }
        },
      ),
    );
  }
}
