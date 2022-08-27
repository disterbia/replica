import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test2 extends StatelessWidget {
  Test2({this.param});
  String? param;
  @override
  Widget build(BuildContext context) {
    print(param);
    _callAPI();
    return Container();
  }

  void _callAPI() async {
    String restapi = "eb360f5265f10401f056c9c56bcb7861";
    String redirect = "http://localhost:5000/test2";
    // var url = Uri.parse(
    //   'https://raw.githubusercontent.com/dev-yakuza/users/master/api.json',
    // );
    // var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    var url = Uri.parse('https://kauth.kakao.com/oauth/token');
    var response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"},body : {
      'grant_type': 'authorization_code',
      'client_id':restapi,
      'redirect_uri':redirect,
      'code':param
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var json = jsonDecode(response.body)['access_token'];
    print("=========$json");
    url = Uri.parse("https://kapi.kakao.com/v2/user/me");
     response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded",  "Authorization": "Bearer $json"},body : {
    });
     print(response.body);
  }
}
