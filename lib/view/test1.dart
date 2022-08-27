import 'dart:html' as HTML;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String restapi = "eb360f5265f10401f056c9c56bcb7861";
    String redirect = "http://localhost:5000/test2";
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
          child: Text("rr"),
          onPressed: ()  {
            HTML.window.location.href = 'https://kauth.kakao'
                '.com/oauth/authorize?response_type=code&client_id=$restapi&redirect_uri=$redirect&response_type=code&scope=account_email,gender';
          },
        ),
      ]),
    );
  }


}
