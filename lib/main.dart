import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panda/router/myGoRouter.dart';
import 'package:panda/util/custom_scroll.dart';
import 'package:url_strategy/url_strategy.dart';


void main() async {
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   bool inDebug = false;
  //   assert(() { inDebug = true; return true; }());
  //   // In debug mode, use the normal error widget which shows
  //   // the error message:
  //   if (inDebug)
  //     return ErrorWidget(details.exception);
  //   // In release builds, show a yellow-on-blue message instead:
  //   return Container(
  //     alignment: Alignment.center,
  //     child: Text(
  //       'Error! ${details.exception}',
  //       style: TextStyle(color: Colors.yellow),
  //       textDirection: TextDirection.ltr,
  //     ),
  //   );
  // };
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDWaktX1bwYSXv0iFjpDC2JZuxSnlxzacs",
          appId: "1:854934436212:web:97cc23dc830f7546841421",
          messagingSenderId: "854934436212",
          authDomain: "replica-e115a.firebaseapp.com",
          projectId: "replica-e115a",
          storageBucket: "gs://replica-e115a.appspot.com"));
  await GetStorage.init();
  setPathUrlStrategy(); //샵없애기
  runApp(GetMaterialApp.router(
    scrollBehavior: CustomScroll(),
    title: "Musita",
    debugShowCheckedModeBanner: false,
    routeInformationParser: MyPages.router.routeInformationParser,
    routerDelegate: MyPages.router.routerDelegate,
    routeInformationProvider: MyPages.router.routeInformationProvider,
    // getPages: AppPages.pages,
    // routerDelegate: AppRouterDelegate(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
