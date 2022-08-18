import 'package:get/get.dart';
import 'package:panda/view/detail_page.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/join_page.dart';
import 'package:panda/view/my_page.dart';
import 'package:panda/view/order_page.dart';
import 'package:panda/view/sign_in.dart';
import 'package:panda/view/temp_page.dart';
import 'package:panda/view/update_page.dart';
import 'package:panda/view/write_page.dart';

abstract class Routes {
  static const TEMP = '/';
  static const HOME = '/home/:index';
  static const DETAIL = '/detail/:index';
  static const JOIN = '/join';
  static const LOGIN  = '/login';
  static const ORDER = '/detail/:index/order';
  static const MYPAGE = '/mypage';
  static const WRITE = '/write';
  static const UPDATE = "/update/:index";
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TEMP,
      page: () => TempPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
        transition: Transition.fadeIn

    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DetailPage(),
        transition: Transition.fadeIn

    ),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginPage() ,
        transition: Transition.fadeIn

    ),
    GetPage(
        name: Routes.JOIN,
        page: () => JoinPage() ,
        transition: Transition.fadeIn

    ),
    GetPage(
        name: Routes.ORDER,
        page: () => OrderPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: Routes.MYPAGE,
        page: () => MyPage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: Routes.WRITE,
        page: () => WritePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: Routes.UPDATE,
        page: () => UpdatePage(),
        transition: Transition.fadeIn
    ),

  ];
}