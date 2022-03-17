import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:panda/controller/post_controller.dart';
import 'package:panda/view/write_page.dart';

import 'detail_page.dart';

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
    final List<bool> _selections = List.generate(6, (index) => false).obs;
    ProductController p = Get.put(ProductController());
    bool isDeskTop = GetPlatform.isDesktop;

    return Obx(
      ()=> WillPopScope(onWillPop: ()async => true,
        child: Scaffold(
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.redAccent,
            overlayColor: Colors.grey,
            overlayOpacity: 0.5,
            spacing: 15,
            spaceBetweenChildren: 15,
            closeManually: false,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.share_rounded),
                  label: '상품등록',
                  backgroundColor: Colors.blue,
                  onTap: (){
                    Get.to(()=>WritePage());
                  }
              ),
              SpeedDialChild(
                  child: Icon(Icons.mail),
                  label: 'Mail',
                  onTap: (){
                    print('Mail Tapped');
                  }
              ),
              SpeedDialChild(
                  child: Icon(Icons.copy),
                  label: 'Copy',
                  onTap: (){
                    print('Copy Tapped');
                  }
              ),
              SpeedDialChild(),
            ],
          ),
          body: Column(
            children: [
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
                    onPressed: (index)  {
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
                      imageBuilder: (context, imageProvider) => GestureDetector(
                        onTap: () async {
                          await p.findById(p.products[index].id!);
                          Get.to(() => DetailPage(),transition: Transition.size);
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
