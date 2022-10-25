import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:panda/view/detail_page.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/join_page.dart';
import 'package:panda/view/my_page.dart';
import 'package:panda/view/order_page.dart';
import 'package:panda/view/sign_in.dart';
import 'package:panda/view/temp_page.dart';
import 'package:panda/view/temp_update.dart';
import 'package:panda/view/test1.dart';
import 'package:panda/view/test2.dart';
import 'package:panda/view/test3.dart';
import 'package:panda/view/test4.dart';
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
  static const TEMPUPDATE = "/temp_update";
  static const TEST1 = "/test1";
  static const TEST2 = "/test2";
  static const TEST3= "/test3";
  static const TEST4= "/test4";
}

class MyPages {
  static late final  router = GoRouter(
    redirect: (state)  {
      String? uid=GetStorage().read("uid");
      final loggedIn =uid==null? false:true;
      final loggingIn = state.subloc == '/login';
      final orderingIn = state.subloc.contains("/order");
      final joiningIn = state.subloc == '/join';
      final writingIn = state.subloc.contains("/write");
      final updatingIn = state.subloc.contains("update");

      if(loggedIn) {
        return loggingIn||joiningIn ?'/': writingIn||updatingIn ? uid!="chRfCQk6Z0S857O88T2A6aAKOVg2" ? '/' : null : null;
      } else if(orderingIn||writingIn||updatingIn) {
        return '/';
      }

      //if (!loggedIn) return loggingIn ? null : '/login';
      //if (loggingIn) return '/';


      return null;
    } ,
    errorBuilder: (context, state) => Container(),
    routes: [
      GoRoute(
        path: MyRoutes.TEMP,
        builder: (context, state) => TempPage()
      ),
      GoRoute(
        path: MyRoutes.HOME,
        builder: (context, state) => HomePage(param:state.params['index'])


      ),
      GoRoute(
        path: MyRoutes.DETAIL,
        builder: (context, state) =>  DetailPage(param:state.params['index']),
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
        builder: (context, state) =>  OrderPage(param: state.params['index'],),
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
        builder: (context, state) =>  UpdatePage(param: state.params['index']),
      ),
      GoRoute(
        path: MyRoutes.TEMPUPDATE,
        builder: (context, state) =>  TempUpdate(),
      ),
      GoRoute(
        path: MyRoutes.TEST1,
        builder: (context, state) =>  Test1(),
      ),
      GoRoute(
        path: MyRoutes.TEST2,
        builder: (context, state) {
          return Test2(param:state.queryParams['code']);
        },
      ),
      // GoRoute(
      //   path: MyRoutes.TEST3,
      //   builder: (context, state) {
      //     return Test3();
      //   },
      // ),
      GoRoute(
        path: MyRoutes.TEST4,
        builder: (context, state) {
          return Test4();
        },
      ),
    ],
  );
}