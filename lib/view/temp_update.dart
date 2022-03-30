import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/controller/temp_controller.dart';
import 'package:panda/model/temp.dart';
import 'package:panda/util/validator_util.dart';

class TempUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TempContrlloer t = Get.find();
    final _url = TextEditingController();

    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            CustomTextFormField(hint: "network image url", funValidator: validateContent(),controller: _url,),
            TextButton(onPressed: () async {
              await t.save(Temp(url: _url.text));
            }, child: Text("추가")),
            Container(height: 500,
              child: ListView.builder(itemCount: t.temps.length,
                itemBuilder: (context, index) {
                  return Row(children: [
                    Expanded(flex: 10,child: CachedNetworkImage(imageUrl: t.temps[index].url!)),
                    Expanded(flex:1,
                      child: TextButton(onPressed: () async {
                        await t.delete(t.temps[index].id!);
                      }, child: Text("삭제")),
                    )
                  ],);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
