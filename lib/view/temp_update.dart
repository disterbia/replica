import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panda/controller/temp_controller.dart';
import 'package:panda/model/temp.dart';

class TempUpdate extends GetView<TempContrlloer> {


  @override
  Widget build(BuildContext context) {
    TempContrlloer t = Get.put(TempContrlloer());
    //final _url = TextEditingController();

    return controller.obx(
            (state) => Obx(
          () => Scaffold(
        body: ListView(
          children: [
            // CustomTextFormField(hint: "network image url", funValidator: validateContent(),controller: _url,),
            // TextButton(onPressed: () async {
            //   await t.save(Temp(url: _url.text));
            // }, child: Text("추가")),
            ElevatedButton(
                onPressed: () async {
                  List<XFile>? pickedFile =
                  await ImagePicker().pickMultiImage();
                  List<String> urlList=await t.uploadImageToStorage(pickedFile);
                  for(var i =0;i<urlList.length;i++) {
                    await t.save(Temp(url: urlList[i]));
                    context.go("/");
                  }
                },
                child: Text("추가")),
            Container(
              height: 1000,
              child: ListView.builder(padding: EdgeInsets.all(8),
                itemCount: t.temps.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: CachedNetworkImage(fit: BoxFit.contain,
                              imageUrl: t.temps[index].url!)),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                            onPressed: () async {
                              await FirebaseStorage.instance.refFromURL(t.temps[index].url!).delete();
                              await t.delete(t.temps[index].id!);
                            },
                            child: Text("삭제")),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
        onLoading: Center(child: Container(height:50,width:50,child: CircularProgressIndicator()))
    );
  }
}
