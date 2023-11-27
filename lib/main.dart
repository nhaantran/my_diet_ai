import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'common/routes/pages.dart';
import 'common/services/storage.dart';
import 'common/store/config.dart';
import 'common/store/user.dart';
import 'firebase_options.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<ConfigStore>(ConfigStore());
  Get.put<UserStore>(UserStore());
  await Firebase.initializeApp(
    //name: 'login demo project',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OpenFoodAPIConfiguration.globalUser = const User(
    userId: 'nhaantran',
    password: 'thanhNHAN2002',
  );
  OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
    OpenFoodFactsLanguage.ENGLISH,
  ];
  OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.USA;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: ((context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(fontFamily: 'OpenSans'),
              title: 'Dialog',
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            )));
  }
}
