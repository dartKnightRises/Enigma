import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app_router.dart';
import 'local_auth/auth_controller.dart';


void main() {
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
      initialRoute: Routes.landing,
      getPages: Routes.routes,


    );
  }
}

