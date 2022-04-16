import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/controller/user_controller.dart';
import 'package:panda/view/sign_in.dart';
import 'package:panda/view/temp_page.dart';
import 'package:panda/view/write_page.dart';

import '../components/cumstom_floating.dart';
import '../util/validator_util.dart';
import 'detail_page.dart';
import 'join_page.dart';
import 'my_page.dart';

class HomePage extends StatelessWidget {
  final _search = TextEditingController();
  final _selections = Get.arguments['selection'];
  final _index = Get.arguments["index"];
  ProductController p = Get.put(ProductController());
  UserController u = Get.put(UserController());
  bool isDeskTop = GetPlatform.isDesktop;
  String nowCategory2 = "";
  final List<String> categoris = [
    "남성의류",
    "여성의류",
    "남성신발",
    "여성신발",
    "운동화",
    "가방/지갑/악세사리"
  ];

  @override
  Widget build(BuildContext context) {
    String nowCategory = categoris[_index];


    // final el = window.document.getElementById('__ff-recaptcha-container');
    // if (el != null) {
    //   el.style.visibility = 'hidden';
    // }

    List<Widget> createButton(int a, int b) {
      List<Widget> list = [];
      for (int i = a; i < categoris.length; i++) {
        if (i == b) break;
        list.add(ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(50, 50),
              primary: _selections[i] ? Colors.grey : Colors.transparent,
              shadowColor: Colors.transparent,
              onPrimary: Colors.black),
          onPressed: () {
            for (int j = 0; j < _selections.length; j++) {
              _selections[j] = i == j;
            }
            nowCategory = categoris[i];
            p.changeCategory(categoris[i]);
            _search.clear();
          },
          child: Text(categoris[i], style: TextStyle(color: Colors.black)),
        ));
      }
      return list;
    }
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: CustomFloating(u: u),
            body: Center(
              child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Column(
                                  children: [
                      GestureDetector(onTap:()=> Get.to(()=>TempPage()),
                        child: Container(height: 100,
                          child: Image.asset("assets/logo.png"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      isDeskTop
                          ? Row(children: createButton(0, 6))
                          : Column(
                        children: [
                          Row(children: createButton(0, 3)),
                          Row(children: createButton(3, 6))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            SizedBox(width: 300,
                                child: TextFormField(
                                  onFieldSubmitted: (v){
                                    p.search(v, nowCategory);
                                  },
                                  controller: _search,
                                  decoration: InputDecoration(
                                    hintText: '$nowCategory 상품 검색',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                )),
                            TextButton.icon(
                              onPressed: () {
                                p.search(_search.text, nowCategory);
                              },
                              icon: Icon(Icons.search),
                              label: Text("검색"),),
                          ],
                        ),
                      ),
                      Container(width: 1400,
                        child: GridView.builder( physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: p.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDeskTop ? 4 : 2,
                            crossAxisSpacing: 10,mainAxisSpacing: 20,
                            childAspectRatio: isDeskTop
                                ? 0.8
                                : 0.7,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Expanded(flex:10,
                                  child: CachedNetworkImage(
                                    imageUrl: p.products[index].mainImageUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                // colorFilter:
                                                // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            await p.findById(p.products[index].id!);
                                            Get.to(() => DetailPage(),
                                                transition: Transition.size);
                                          },
                                        ),
                                    //placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Expanded(child: Text(p.products[index].name!,style: TextStyle(fontWeight: FontWeight.bold),)),
                                Expanded(child: Text(p.products[index].comment!)),
                                Expanded(child: Text(NumberFormat("###,###,### 원").format(int.parse(p.products[index].price!)),style: TextStyle(color: Colors.orange),)),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
