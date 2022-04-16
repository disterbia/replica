import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final funValidator;
  final controller;
  final funSubmit;

  const CustomTextFormField({
    required this.hint,
     this.funValidator,
    this.controller,
    this.funSubmit
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(width: 800,
        child: TextFormField(onFieldSubmitted:(v) {
          funSubmit();
          },
          controller: controller,
          validator: funValidator,
          obscureText: hint == "Password" ? true : false,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
