import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/temp_controller.dart';
import 'package:panda/view/home_page.dart';

import '../controller/user_controller.dart';

class TempPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TempContrlloer t = Get.put(TempContrlloer());
    UserController u = Get.put(UserController());

    bool isDeskTop = GetPlatform.isDesktop;
    final List<String> categoris = [
      "남성의류",
      "여성의류",
      "남성신발",
      "여성신발",
      "운동화",
      "가방/지갑/악세사리"
    ];
    final List<bool> _selections = List.generate(6, (index) => false);

    return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset("assets/logo.png"),
                        ),
                        TextButton(onPressed: (){
                        }, child: Text("추가"))
                      ],
                    ),
                    flex: 2,
                  ),
                  Expanded(child: Container(),flex:10),
                  // CarouselSlider(
                  //     items: items,
                  //     options: CarouselOptions(
                  //       height: 400,
                  //       aspectRatio: 16/9,
                  //       viewportFraction: 0.8,
                  //       initialPage: 0,
                  //       enableInfiniteScroll: true,
                  //       reverse: false,
                  //       autoPlay: true,
                  //       autoPlayInterval: Duration(seconds: 3),
                  //       autoPlayAnimationDuration: Duration(milliseconds: 800),
                  //       autoPlayCurve: Curves.fastOutSlowIn,
                  //       enlargeCenterPage: true,
                  //       scrollDirection: Axis.horizontal,
                  //     )
                  // )
                  Expanded(
                    flex: 1,
                    child: ToggleButtons(
                       children: [
                         Text(categoris[0]),
                         Text(categoris[1]),
                         Text(categoris[2]),
                         Text(categoris[3]),
                         Text(categoris[4]),
                         Text(categoris[5])
                       ],
                       isSelected: _selections,
                       onPressed: (index) {
                         for (int i = 0; i < _selections.length; i++) {
                           _selections[i] = i == index;
                         }
                         Get.to(()=>HomePage(),arguments: {"list":_selections,"category":categoris[index]},);
                       },
                     ),
                  )
                ],
              ),
            ),
          ),
        );
  }
}
