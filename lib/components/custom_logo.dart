import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MouseRegion(cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: () => Get.rootDelegate.toNamed("/"),
          child: Container(
            height: 100,
            child: Image.asset("assets/logo.png"),
          )),
    );
  }
}
