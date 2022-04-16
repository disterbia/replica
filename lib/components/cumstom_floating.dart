import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/user_controller.dart';
import '../view/join_page.dart';
import '../view/my_page.dart';
import '../view/sign_in.dart';
import '../view/write_page.dart';

class CustomFloating extends StatelessWidget {
  CustomFloating({
    required this.u,
  }) ;

  final UserController u;

  void logout(){
    u.logout();
    Get.to(()=>LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(direction:SpeedDialDirection.down ,switchLabelPosition: true,
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Colors.redAccent,
      overlayColor: Colors.grey,
      overlayOpacity: 0.5,
      spacing: 15,
      spaceBetweenChildren: 15,
      closeManually: false,
      children: [
        u.principal.value.uid  == "chRfCQk6Z0S857O88T2A6aAKOVg2"
            ? SpeedDialChild(
            child: Icon(Icons.share_rounded),
            label: "상품등록",
            backgroundColor: Colors.blue,
            onTap: () {
              Get.to(() => WritePage());
            })
            : SpeedDialChild(),
        SpeedDialChild(
            child: Icon(Icons.share_rounded),
            label: u.principal.value.uid != null ? "로그아웃" : "로그인",
            backgroundColor: Colors.blue,
            onTap: () {
              u.principal.value.uid != null ? logout(): Get.to(() => LoginPage());
            }),
        SpeedDialChild(
            child: Icon(Icons.mail),
            label: u.principal.value.uid != null? "마이페이지" : "회원가입",
            onTap: () {
              Get.to(() => u.principal.value.uid != null ? MyPage() : JoinPage());
            }),
      ],
    );
  }
}
