import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../controller/user_controller.dart';

class CustomFloating extends StatelessWidget {
  CustomFloating({
    required this.u,
  }) ;

  final UserController u;

  Future<void> logout(BuildContext context) async{
    await u.logout();
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    String? uid= GetStorage().read("uid");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpeedDial(direction:SpeedDialDirection.down ,switchLabelPosition: true,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.redAccent,
        overlayColor: Colors.grey,
        overlayOpacity: 0,
        spacing: 15,
        spaceBetweenChildren: 15,
        closeManually: false,
        children: [
          uid  == "chRfCQk6Z0S857O88T2A6aAKOVg2"
              ? SpeedDialChild(
              child: Icon(Icons.share_rounded),
              label: "상품등록",
              backgroundColor: Colors.blue,
              onTap: () {
                context.go("/write");
              })
              : SpeedDialChild(),
          SpeedDialChild(
              child: Icon(Icons.share_rounded),
              label: uid != null ? "로그아웃" : "로그인",
              backgroundColor: Colors.blue,
              onTap: () {
                uid != null ? logout(context): context.go("/login");
              }),
          SpeedDialChild(
              child: Icon(Icons.mail),
              label: uid != null? "마이페이지" : "회원가입",
              onTap: () {
                context.go(uid != null ? '/mypage' : '/join');
              }),
        ],
      ),
    );
  }
}
