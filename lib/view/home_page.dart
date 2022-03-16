import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/post_controller.dart';
import 'package:panda/view/write_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductController p = Get.put(ProductController());
    bool isDeskTop =GetPlatform.isDesktop;
    return Column(children: [
      Expanded(flex: 1,
        child: Row(children: [
          ElevatedButton(onPressed: (){Get.to(()=>WritePage());}, child: Text("aa")),
          ElevatedButton(onPressed: (){}, child: Text("bb")),
          ElevatedButton(onPressed: (){}, child: Text("cc"))
        ],),
      ),
      Expanded(flex:10,
        child: Obx(
    ()=> GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: isDeskTop ? 4:2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(p.products.length, (index) {
              return CachedNetworkImage(
                imageUrl: p.products[index].mainImageUrl!,
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
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            }),
          ),
        ),
      ),
    ],);
  }
}
