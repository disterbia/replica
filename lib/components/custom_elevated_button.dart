import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final funPageRoute;

  const CustomElevatedButton({required this.text, required this.funPageRoute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(100, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: funPageRoute,
      child: Text("$text"),
    );
  }
}
