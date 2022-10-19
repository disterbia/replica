import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:panda/components/custom_logo.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/temp_controller.dart';

import '../components/cumstom_floating.dart';
import '../controller/user_controller.dart';

class TempPage extends GetView<TempContrlloer> {

  TempContrlloer t = Get.put(TempContrlloer());
  UserController u = Get.put(UserController());
  ProductController p = Get.put(ProductController());

  bool isDeskTop = GetPlatform.isDesktop;
  final List<String> categoris = [
    "남성의류",
    "여성의류",
    "남성신발",
    "여성신발",
    "운동화",
    "가방/지갑/악세사리"
  ];

  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
          (state)
           => Obx(
             ()=> SafeArea(
               child: Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startTop,
                  floatingActionButton: CustomFloating(u: u),
                  body: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLogo(),
                            u.principal.value.uid == "chRfCQk6Z0S857O88T2A6aAKOVg2"
                                ? TextButton(
                                    onPressed: () {
                                     context.go("/temp_update");
                                    },
                                    child: Text("편집"))
                                : Container()
                          ],
                        ),
                        flex: 3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 10,
                        child: CarouselSlider.builder(
                            carouselController: buttonCarouselController,
                            itemBuilder: (context, index, realIndex) {
                              return t.temps.isEmpty
                                  ? Container()
                                  : CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain,
                                            // colorFilter:
                                            // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                          ),
                                        ),
                                      ),
                                      imageUrl: t.temps[index].url!,
                                    );
                            },
                            itemCount: t.temps.length,
                            options: CarouselOptions(
                              height: 600,
                              aspectRatio: 1,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            )),
                      ),
                      isDeskTop
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(10, 10),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      onPrimary: Colors.black),
                                  onPressed: () =>
                                      buttonCarouselController.previousPage(
                                          duration: Duration(milliseconds: 400)),
                                  child: Text("<",
                                      style: TextStyle(color: Colors.black)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(10, 10),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      onPrimary: Colors.black),
                                  onPressed: () =>
                                      buttonCarouselController.nextPage(
                                          duration: Duration(milliseconds: 400)),
                                  child: Text(">",
                                      style: TextStyle(color: Colors.black)),
                                )
                              ],
                            )
                          : Container(),
                      Expanded(
                          flex: 2,
                          child: isDeskTop
                              ? Row(children: createButton(0, 6,context))
                              : Column(
                                  children: [
                                    Expanded(
                                        child: Row(children: createButton(0, 3,context))),
                                    Expanded(
                                        child: Row(children: createButton(3, 6,context)))
                                  ],
                                ))
                    ],
                  ),
                ),
             ),
           ),

        onLoading: Center(child: Container(height:50,width:50,child: CircularProgressIndicator()))
        );

  }

  List<Widget> createButton(int a, int b,BuildContext context) {
    List<Widget> list = [];
    for (int i = a; i < categoris.length; i++) {
      if (i == b) break;
      list.add(Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              onPrimary: Colors.black),
          onPressed: () {
            context.go("/home/$i",);
            //Get.rootDelegate.toNamed("/home/$i");
          },
          child: Text(categoris[i], style: TextStyle(color: Colors.black)),
        ),
      ));
    }
    return list;
  }

}
