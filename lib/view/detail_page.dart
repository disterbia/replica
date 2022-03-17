import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/post_controller.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductController p = Get.find();

    return Obx(
      () => ListView(
        children: [
          SizedBox(height: 500,),
          ListView.separated(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LimitedBox(maxWidth: 500,maxHeight: 500 ,
                      child: CachedNetworkImage(
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
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          print(error);
                          return Icon(Icons.error);
                        },
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: p.product.value.detailImageUrl!.length)
        ],
      ),
    );
  }
}
