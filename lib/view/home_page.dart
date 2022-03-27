import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/view/sign_in.dart';
import 'package:panda/view/write_page.dart';

import '../components/cumstom_floating.dart';
import 'detail_page.dart';
import 'join_page.dart';
import 'my_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> categoris = [
      "남성의류",
      "여성의류",
      "남성신발",
      "여성신발",
      "운동화",
      "가방/지갑/악세사리"
    ];
    final _selections = Get.arguments['list'];
    ProductController p = Get.put(ProductController());
    UserController u = Get.put(UserController());
    bool isDeskTop = GetPlatform.isDesktop;
    p.changeCategory(Get.arguments['category']);

    // final el = window.document.getElementById('__ff-recaptcha-container');
    // if (el != null) {
    //   el.style.visibility = 'hidden';
    // }
    return Obx(
      () => SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: CustomFloating(u: u),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(child: Image.asset("assets/logo.png")),
                      Expanded(
                          child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                              label: Text("상품검색")))
                    ],
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
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
                      p.changeCategory(categoris[index]);
                    },
                    selectedColor: Colors.red,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: isDeskTop ? 4 : 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(p.products.length, (index) {
                    return CachedNetworkImage(
                      imageUrl: p.products[index].mainImageUrl!,
                      imageBuilder: (context, imageProvider) =>
                          GestureDetector(
                        onTap: () async {
                          await p.findById(p.products[index].id!);
                          Get.to(() => DetailPage(),
                              transition: Transition.size);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                              // colorFilter:
                              // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                            ),
                          ),
                        ),
                      ),
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
