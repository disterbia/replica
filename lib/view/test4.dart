import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:panda/view/map_view.dart';

class Test4 extends StatefulWidget {
  const Test4({Key? key}) : super(key: key);

  @override
  State<Test4> createState() => _Test4State();
}

class _Test4State extends State<Test4> {
  String? addressName;
  @override
  Widget build(BuildContext context) {
    print("ff");
    return  Scaffold(
      appBar: AppBar(title: Text("카카오 우편번호 서비스 : ${addressName ?? '검색해주세요'}"),),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("주소 검색"),
            onPressed: () async{
               js.context.callMethod("aa");
              // await Navigator.of(context).push(
              //     MaterialPageRoute(
              //         settings: RouteSettings(
              //             name: '/k'
              //         ),
              //         builder: (BuildContext context) => MapV()
              //     )
              // );
              js.JsObject obj = js.JsObject.fromBrowserObject(js.context['add']);//주소선택했을때 이걸 어떻게 재호출할까..
              print(obj['extraAddr'].toString());
              print(obj['zonecode'].toString());
              print(obj['addr'].toString());
              print(obj['data'].toString());
              setState(() {
                this.addressName = obj['data'].toString();
              });
            },
          ),
        ),
      ),
    );
  }
}
