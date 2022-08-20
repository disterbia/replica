import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:panda/view/detail_page.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/join_page.dart';
import 'package:panda/view/my_page.dart';
import 'package:panda/view/order_page.dart';
import 'package:panda/view/sign_in.dart';
import 'package:panda/view/temp_page.dart';
import 'package:panda/view/temp_update.dart';
import 'package:panda/view/update_page.dart';
import 'package:panda/view/write_page.dart';

class MyRoutes {
  static const TEMP = '/';
  static const HOME = '/home/:index';
  static const DETAIL = '/detail/:index';
  static const JOIN = '/join';
  static const LOGIN  = '/login';
  static const ORDER = '/detail/:index/order';
  static const MYPAGE = '/mypage';
  static const WRITE = '/write';
  static const UPDATE = "/update/:index";
  static const TEMPUPDATE = "/temp_update/:index";
}

class MyPages {
  static final  router = GoRouter(
    errorBuilder: (context, state) => Container(),
    routes: [
      GoRoute(
        path: MyRoutes.TEMP,
        builder: (context, state) => TempPage()
      ),
      GoRoute(
        path: MyRoutes.HOME,
        builder: (context, state) {
          return HomePage(param:state.params['index']);
        }

      ),
      GoRoute(
        path: MyRoutes.DETAIL,
        builder: (context, state) =>  DetailPage(),
      ),
      GoRoute(
        path: MyRoutes.JOIN,
        builder: (context, state) => JoinPage(),
      ),
      GoRoute(
        path: MyRoutes.LOGIN,
        builder: (context, state) =>  LoginPage(),
      ),
      GoRoute(
        path: MyRoutes.ORDER,
        builder: (context, state) =>  OrderPage(),
      ),
      GoRoute(
        path: MyRoutes.MYPAGE,
        builder: (context, state) =>  MyPage(),
      ),
      GoRoute(
        path: MyRoutes.WRITE,
        builder: (context, state) =>  WritePage(),
      ),
      GoRoute(
        path: MyRoutes.UPDATE,
        builder: (context, state) =>  UpdatePage(),
      ),
      GoRoute(
        path: MyRoutes.TEMPUPDATE,
        builder: (context, state) =>  TempUpdate(),
      ),
    ],
  );
}