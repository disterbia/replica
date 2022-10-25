
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:panda/components/custom_logo.dart';
import 'package:panda/controller/user_controller.dart';

import 'package:panda/util/validator_util.dart';
import 'package:panda/components/custom_elevated_button.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'dart:js' as js;

class JoinPage extends GetView<UserController> {
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.put(UserController());

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _code = TextEditingController();
  BuildContext? _context;
  bool codeResult =false;
  double screenHeight=Get.height;
  double screenWidth=Get.width;
  bool isDeskTop = GetPlatform.isDesktop;
  @override
  Widget build(BuildContext context) {
    _context=context;
    return controller.obx(
      (state)=> Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              CustomLogo(),
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Text(
                  "회원가입 페이지",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _joinForm(),
            ],
          ),
        ),
      ),
        onLoading: Center(child: Container(height:50,width:50,child: CircularProgressIndicator()))
    );
  }
  void funSubmit() async {
    if (_formKey.currentState!.validate()) {
      bool emailCheck = await u.checkEmail(_email.text.trim());
      if (!emailCheck) {
        showDialog(
            context: _context!,
            builder: (context) => AlertDialog(
              title: Text("회원가입 실패"),
              content: Text("중복된 이메일 입니다."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                )
              ],
            ));
        return;
      }
      if(!codeResult){
        showDialog(
            context: _context!,
            builder: (context) => AlertDialog(
              title: Text("회원가입 실패"),
              content: Text("인증번호를 확인해주세요."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                )
              ],
            ));
        return;
      }
      bool result = await u.join(
          _email.text.trim(),
          _password.text.trim(),
          _username.text.trim(),
          _phoneNumber.text.trim());

      if (result) {
        Router.neglect(_context!, () {
          _context!.go("/");
        });


      } else {
        showDialog(
            context: _context!,
            builder: (context) => AlertDialog(
              title: Text("회원가입 실패"),
              content: Text("회원가입 실패."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                )
              ],
            ));
      }
    }
  }
  Widget _joinForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    child: CustomTextFormField(funSubmit: funSubmit,
                      hint: "Email",
                      controller: _email,
                      funValidator: validateEmail(),
                    ),
                  ),
                ),
                isDeskTop?Container(width: 100,):Container(),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CustomTextFormField(funSubmit: funSubmit,
                    hint: "Password",
                    controller: _password,
                    funValidator: validatePassword(),
                  ),
                ),
                isDeskTop?Container(width: 100,):Container(),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CustomTextFormField(funSubmit: funSubmit,
                    hint: "Name",
                    controller: _username,
                    funValidator: validateUsername(),
                  ),
                ),
                isDeskTop?Container(width: 100,):Container(),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CustomTextFormField(funSubmit: funSubmit,
                    hint: "Phone Number",
                    controller: _phoneNumber,
                    funValidator: validatePhoneNumber(),
                  ),
                ),
                Container(width: 100,
                  child: TextButton(
                      onPressed: () async {
                        bool result = await u.checkPhoneNumber(_phoneNumber.text);
                        showDialog(
                            context: _context!,
                            builder: (context) => AlertDialog(
                              title: Text(result ? "전송완료" : "전송실패",),
                              content: Text(result ? "휴대폰으로 전송된 인증번호를 입력하세요" : "전화번호를 다시 확인하세요",),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    return Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ));
                      },
                      child: Text(
                        "인증번호\n전송",
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CustomTextFormField(funSubmit: funSubmit,
                    hint: "인증번호",
                    controller: _code,
                    funValidator: validateCode(),
                  ),
                ),
                Container(width: 100,
                  child: TextButton(
                      onPressed: () async {
                         codeResult = await u.checkCode(_code.text);
                        showDialog(
                            context: _context!,
                            builder: (context) => AlertDialog(
                              title: Text(codeResult ? "인증성공" : "인증실패",),
                              content: Text(codeResult ? "회원가입 버튼을 누르세요." : "인증번호를 다시 확인해 주세요.",),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    return Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ));
                      },
                      child: Text("인증")),
                )
              ],
            ),
            CustomElevatedButton(
              text: "회원가입",
              funPageRoute: funSubmit
            ),
            TextButton(
              onPressed: () {
                _context!.go("/login");
              },
              child: Text("로그인 페이지로 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
