import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/router/AppRouterDelegate.dart';
import 'package:panda/router/MyFRouter.dart';
import 'package:panda/router/MyRoutes.dart';
import 'package:panda/util/custom_scroll.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/temp_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDWaktX1bwYSXv0iFjpDC2JZuxSnlxzacs",
          appId: "1:854934436212:web:97cc23dc830f7546841421",
          messagingSenderId: "854934436212",
          projectId: "replica-e115a"));
  await GetStorage.init();
  setPathUrlStrategy(); //샵없애기
  //MyFRouter.setupRouter();
  Get.put(ProductController());
  Get.put(UserController());
  runApp(GetMaterialApp.router(scrollBehavior: CustomScroll(),
    debugShowCheckedModeBanner: false,
    getPages: AppPages.pages,
    routerDelegate: AppRouterDelegate(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return Container();
  }
}
