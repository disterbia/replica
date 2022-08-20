import 'package:flutter/material.dart';
import 'package:panda/components/custom_logo.dart';
import 'package:panda/controller/user_controller.dart';

import 'package:panda/util/validator_util.dart';
import 'package:panda/components/custom_elevated_button.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/view/temp_page.dart';
import 'package:get/get.dart';


class LoginPage extends GetView<UserController> {
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.put(UserController());
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        Get.rootDelegate.offNamed("/",); // Error: Unexpected null value.
      } else {
        Get.dialog(Container());
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
              Get.rootDelegate.toNamed("/join");
            },
            child: Text("아직 회원가입이 안되어 있나요?"),
          ),
        ],
      ),
    );
  }
}
