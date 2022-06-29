import 'package:get/get.dart';
import 'package:panda/view/detail_page.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/temp_page.dart';

abstract class Routes {
  static const TEMP = '/';
  static const HOME = '/home/:index';
  static const DETAIL = '/detail/:index';
  static const SIGNUP = '/signup';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TEMP,
      page: () => TempPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),

    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DetailPage(),

    ),

  ];
}