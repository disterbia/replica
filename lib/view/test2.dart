import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:panda/controller/user_controller.dart';

class Test2 extends GetView<UserController> {

  Test2({this.param});
  String? param;
  bool data=false;
  final UserController u = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    _callAPI(context);
    return Center(child: Container(height:50,width:50,child: CircularProgressIndicator()));
  }

  Future<void> _callAPI(BuildContext context) async {
    String restapi = "eb360f5265f10401f056c9c56bcb7861";
    String redirect = "http://localhost:5000/test2";
    String email="";
    // var url = Uri.parse(
    //   'https://raw.githubusercontent.com/dev-yakuza/users/master/api.json',
    // );
    // var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    try{
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
      // url = Uri.parse("https://kapi.kakao.com/v1/user/unlink");
      //  await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded",  "Authorization": "Bearer $json"},body : {
      // });
      url = Uri.parse("https://kapi.kakao.com/v2/user/me");
      response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded",  "Authorization": "Bearer $json"},body : {
      });
      Map<String,dynamic> list = jsonDecode(response.body);
      Map<String,dynamic> list2 = list["kakao_account"];
      email=list2["email"];
      bool result= await u.checkEmail(email);
      if(result){
        await u.join(email, "freedom67!", "kakao", "000");
        Router.neglect(context, () {
          context.go("/");
        });

      }else{
        data=await u.login(email, "freedom67!");
        Router.neglect(context, () {
          context.go("/");
        });
      }
      // print("--------$email");
      //print(response.body);
    }catch(e){

    }
  }
}
