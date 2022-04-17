import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/sign_in.dart';
import 'package:panda/view/temp_page.dart';
import 'package:panda/view/update_page.dart';
import 'package:panda/view/write_page.dart';
import '../components/cumstom_floating.dart';
import '../components/custom_elevated_button.dart';
import 'order_page.dart';

class DetailPage extends StatelessWidget {
  ProductController p = Get.find();
  UserController u = Get.find();
  bool isDesktop = GetPlatform.isDesktop;
  RxString _sizeValue="".obs;

  @override
  Widget build(BuildContext context) {
    _sizeValue.value=p.product.value.size!.first;
    return Obx(
      () => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: CustomFloating(u: u),
            body: Center(
              child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(child: Column(
                    children: [
                      GestureDetector(onTap:()=> Get.to(()=>TempPage()),
                      child: Container(
                        height: 100,
                        child: Image.asset("assets/logo.png"),
                      )
                ),
                      SizedBox(
                        height: 10,
                      ),
                      u.principal.value.uid == "chRfCQk6Z0S857O88T2A6aAKOVg2"
                          ? Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.to(() => UpdatePage());
                              },
                              child: Text("수정")),
                          TextButton(
                              onPressed: () async {
                                await p.delete(p.product.value.id!);
                                 Get.off(() => TempPage());
                              },
                              child: Text("삭제")),
                        ],
                      )
                          : Container(),
                      isDesktop
                          ?  Row(children:order(isDesktop) ,
                      )

                          : Column(
                        children: order(isDesktop),
                      ),
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
                      Container(width: 1400,
                        child: ListView.separated(
                          itemCount: p.product.value.detailImageUrl!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Center(
                              child: CachedNetworkImage(
                                height: isDesktop?500:Get.height/2,
                                width: isDesktop?500:Get.height/2,
                                imageUrl: p.product.value.detailImageUrl![index],
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(fit: BoxFit.none,
                                      image: imageProvider,
                                      // colorFilter:
                                      // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
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
                    ]
                ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> order(bool desktop) {
    List<Widget> list = [
      CachedNetworkImage(
        height: 500 ,
        width: 500 ,
        imageUrl: p.product.value.mainImageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              // colorFilter:
              // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
            ),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
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
              p.product.value.size!.first!=""?Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("사이즈: "),
                DropdownButton<String>(
                  focusColor:Colors.white,
                  value: _sizeValue.value,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor:Colors.black,
                  items: p.product.value.size!.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    _sizeValue.value=value!;
                  },
                ),
              ],
            ):Container(),
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
                Get.to(() => u.principal.value.uid==null?LoginPage():OrderPage());
              },
            ),
          ],
        ),
      )
    ];
    //if(desktop) list.insert(0,SizedBox(width: 100,));
    if(desktop) list.insert(1,SizedBox(width: 100,));
    return list;
  }
}
