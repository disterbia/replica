import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:panda/components/custom_logo.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import '../components/cumstom_floating.dart';

class DetailPage extends GetView<ProductController>  {
  DetailPage({this.param});
  String? param;
  ProductController p = Get.put(ProductController());
  UserController u = Get.put(UserController());
  bool isDesktop = GetPlatform.isDesktop;
  final sizeValue = "".obs;

  //final param = Get.rootDelegate.parameters["index"]!;

  @override
  Widget build(BuildContext context) {
    p.findById(param!);
    return controller.obx(
            (state) =>Obx(
        () {
          if (p.isLoading.value) {
            return Center(
                child: Container(
                    height: 50, width: 50, child: CircularProgressIndicator()));
          } else {
            sizeValue.value = p.product.value.size!.first;
            return SafeArea(
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startTop,
                floatingActionButton: CustomFloating(u: u),
                body: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        CustomLogo(),
                        SizedBox(
                          height: 10,
                        ),
                        GetStorage().read("uid") ==
                                "chRfCQk6Z0S857O88T2A6aAKOVg2"
                            ? Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        context.go("/update/$param");
                                        //Get.rootDelegate.toNamed("/update");
                                      },
                                      child: Text("수정")),
                                  TextButton(
                                      onPressed: () async {
                                        await p.delete(p.product.value.id!);
                                        context.go("/");
                                        //Get.rootDelegate.toNamed("/");
                                      },
                                      child: Text("삭제")),
                                ],
                              )
                            : Container(),
                        isDesktop
                            ? Row(children: order(context,isDesktop))
                            // FutureBuilder(future: p.findById(p.products[param].id!),builder: (BuildContext context, AsyncSnapshot snapshot){
                            //       return Row(children:order(isDesktop));
                            // })

                            : Column(children: order(context,isDesktop)),
                        // FutureBuilder(future: p.findById(p.products[param].id!),builder: (BuildContext context, AsyncSnapshot snapshot){
                        //   return Column(children:order(isDesktop));
                        // }),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 1000,
                            height: 30,
                            color: Colors.blueGrey.shade50,
                            child: Center(
                              child: Text(
                                "상품상세보기",
                                style: TextStyle(
                                  fontSize: 20,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.orange,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 1400,
                          child: ListView.separated(
                            itemCount: p.product.value.detailImageUrl!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Center(
                                child: CachedNetworkImage(
                                  height: isDesktop ? 500 : Get.height / 2,
                                  width: isDesktop ? 500 : Get.height / 2,
                                  imageUrl:
                                      p.product.value.detailImageUrl![index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: imageProvider,
                                        // colorFilter:
                                        // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          child:
                                              CircularProgressIndicator())),
                                  errorWidget: (context, url, error) {
                                    print(error);
                                    return Icon(Icons.error);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ));
  }

  List<Widget> order(BuildContext context, bool desktop) {
    List<Widget> list = [
      CachedNetworkImage(
        height: 500,
        width: 500,
        imageUrl: p.product.value.mainImageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover,
              image: imageProvider,
              // colorFilter:
              // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
            ),
          ),
        ),
        placeholder: (context, url) => Center(
            child: Container(
                height: 50, width: 50, child: CircularProgressIndicator())),
        errorWidget: (context, url, error) {
          print(error);
          return Icon(Icons.error);
        },
      ),
      Container(
        child: Column(
          children: [
            Text(
              p.product.value.name!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(p.product.value.comment!),
            SizedBox(
              height: 10,
            ),
            p.product.value.size!.first != ""
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("사이즈: "),
                      Obx(
                            ()=> DropdownButton<String>(
                          focusColor: Colors.white,
                          value: sizeValue.value,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: p.product.value.size!
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            sizeValue.value = value!;
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            Text(
                "판매가격 :  ${NumberFormat("###,###,### 원").format(p.product.value.price!)}"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text("주문하기"),
              onPressed: () {
                context.go(GetStorage().read("uid")== null ? "/login" : "/detail/$param/order");
              },
            ),
          ],
        ),
      )
    ];
    //if(desktop) list.insert(0,SizedBox(width: 100,));
    if (desktop)
      list.insert(
          1,
          SizedBox(
            width: 100,
          ));
    return list;
  }
}
