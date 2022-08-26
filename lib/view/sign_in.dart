import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:panda/components/custom_logo.dart';
import 'package:panda/controller/user_controller.dart';

import 'package:panda/util/validator_util.dart';
import 'package:panda/components/custom_elevated_button.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:get/get.dart';


class LoginPage extends GetView<UserController> {
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.put(UserController());
  final _username = TextEditingController();
  final _password = TextEditingController();
  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    _context=context;
    return controller.obx(
      (state)=> Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomLogo(),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: Text(
                        "로그인 페이지 ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _loginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
        onLoading: Center(child: Container(height:50,width:50,child: CircularProgressIndicator()))
    );
  }
  void funSubmit() async{
    if (_formKey.currentState!.validate()) {
      bool result =
      await u.login(_username.text.trim(), _password.text.trim());
      if (result) {
        _context!.go("/");// Error: Unexpected null value.
      } else {
        showDialog(context: _context!, builder: (context)=> AlertDialog(title:Text("로그인 실패"),
            content: Text("이메일 또는 비밀번호를 확인해주세요"),actions: [
              TextButton(
    child: Text("OK"),
    onPressed: () {return Navigator.of(context).pop(); },
  )
          ],));
        //Get.snackbar("login fail", "check id or password"); // Error: Unexpected null value.
      }
    }
  }
  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(funSubmit:funSubmit,
            controller: _username,
            hint: "Email",
            funValidator: validateEmail(),
          ),
          CustomTextFormField(funSubmit:funSubmit,
            controller: _password,
            hint: "Password",
            funValidator: validatePassword(),
          ),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: funSubmit
          ),
          TextButton(
            onPressed: () {
              AlertDialog();
            },
            child: Text("아직 회원가입이 안되어 있나요?"),
          ),
        ],
      ),
    );
  }
}
