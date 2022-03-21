import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

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
        u.principal.value.email == "tkdtn@tmdgks.com"
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
            label: u.isLogin.value ? "로그아웃" : "로그인",
            backgroundColor: Colors.blue,
            onTap: () {
              u.isLogin.value ? u.logout() : Get.to(() => LoginPage());
            }),
        SpeedDialChild(
            child: Icon(Icons.mail),
            label: u.isLogin.value ? "마이페이지" : "회원가입",
            onTap: () {
              Get.to(() => u.isLogin.value ? MyPage() : JoinPage());
            }),
      ],
    );
  }
}
