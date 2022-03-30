import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/view/home_page.dart';
import 'package:panda/view/update_page.dart';
import 'package:panda/view/write_page.dart';

import '../components/cumstom_floating.dart';
import '../components/custom_elevated_button.dart';
import 'order_page.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductController p = Get.find();
    UserController u = Get.find();

    return Obx(
      () => WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: CustomFloating(u: u),
          body: ListView(
            children: [
              u.principal.value.email == "tkdtn@tmdgks.com"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              Get.to(() => UpdatePage());
                            },
                            child: Text("수정")),
                        TextButton(
                            onPressed: () async {
                              await p.delete(p.product.value.id!);
                              Get.off(() => HomePage());
                            },
                            child: Text("삭제")),
                      ],
                    )
                  : Container(),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    height: 400,
                    width: 300,
                    imageUrl: p.product.value.mainImageUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
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
                  Column(
                    children: [Text("dd"), Text("zz")],
                  )
                ],
              ),
              CustomElevatedButton(
                text: "주문하기",
                funPageRoute: () {
                  Get.to(() => OrderPage());
                },
              ),
              ListView.separated(
                itemCount: p.product.value.detailImageUrl!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        height: 400,
                        width: 300,
                        imageUrl: p.product.value.detailImageUrl![index],
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
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
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
