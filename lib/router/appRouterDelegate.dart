import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/router/myRoutes.dart';

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    if(currentConfiguration==null){print("aaaaaaa");} else print("bbbbbbbb");
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute(Routes.TEMP)!.currentPage!],
    );
  }
}