import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/temp_page.dart';

class MyFRouter{
  static FluroRouter router = FluroRouter();

  static Handler tempPage = Handler(handlerFunc: (BuildContext? context,Map<String,dynamic> params)=>TempPage());

  static Handler homePage = Handler(handlerFunc: (BuildContext? context,Map<String,dynamic> params)=>HomePage()
    // final args=context!.settings?.arguments as Map<String,dynamic>;

  );

  static void setupRouter(){
    router.define("/temp", handler: tempPage,transitionType: TransitionType.fadeIn);
    router.define("/home", handler: homePage,transitionType: TransitionType.fadeIn);


  }
}