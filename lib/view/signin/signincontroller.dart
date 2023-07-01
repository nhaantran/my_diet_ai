import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_diet/common/entities/entities.dart';
import 'package:my_diet/common/store/config.dart';
import 'package:my_diet/common/store/user.dart';
import 'package:my_diet/common/values/formula.dart';
import 'package:my_diet/common/widgets/toast.dart';
import 'package:my_diet/view/welcome/welcomecontroller.dart';

import '../../common/routes/names.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['openid']);

class SignInController extends GetxController {
  var index = 0.obs;
  final db = FirebaseFirestore.instance;
  Future<void> handleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      if (user != null) {
        final gAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: gAuthentication.idToken,
            accessToken: gAuthentication.accessToken);

        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);
        var userbase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userdata, options) =>
                  userdata.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();

        if (userbase.docs.isEmpty) {
          final data = UserData(
              id: id,
              name: displayName,
              email: email,
              photourl: photoUrl,
              location: "",
              fcmtoken: "",
              addtime: Timestamp.now());
          //WelcomeController.user!.id = id;
          print(WelcomeController.user!.toJson());

          await db
              .collection("users")
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userdata, options) =>
                    userdata.toFirestore(),
              )
              .add(data);

          await db
              .collection("usersHealth")
              .doc(id)
              .set(WelcomeController.user!.toJson());
              await db
              .collection("usersHealth")
              .doc(id)
              .update({
                "waterIntake": num.parse((double.parse(WelcomeController.user!.weight) * Formula.WATER_INTAKE).toStringAsFixed(1)),
              });
        }

        toastInfo(msg: "Login Success");
        await ConfigStore.to.saveAlreadyOpen();
        Get.offAndToNamed(AppRoutes.Application);
      }
    } catch (e) {
      toastInfo(msg: "Login Failed");
      print("ERROR: " + e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is currently logged out");
      } else {
        print("User is logged in");
      }
    });
  }

  SignInController();
  changePage(int index) async {
    this.index.value = index;
  }

  moveToSignUp() async {
    Get.offAndToNamed(AppRoutes.SIGN_UP);
  }

  handleSignIn1() async {
    Get.offAndToNamed(AppRoutes.Application);
  }
}
