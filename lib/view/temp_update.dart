import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panda/components/custom_text_form_field.dart';
import 'package:panda/controller/temp_controller.dart';
import 'package:panda/model/temp.dart';
import 'package:path/path.dart' as Path;
import 'package:panda/util/validator_util.dart';

class TempUpdate extends StatelessWidget {


  uploadImageToStorage(List<XFile>? pickedFile) async {
    if (kIsWeb) {
      Reference _reference = FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(pickedFile!.first.path)}');
      await _reference
          .putData(
        await pickedFile.first.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          var uploadedPhotoUrl = value;
          print(uploadedPhotoUrl);
        });
      });
    } else {
      print('fff');
//write a code for android or ios
    }
  }

  @override
  Widget build(BuildContext context) {
    TempContrlloer t = Get.put(TempContrlloer());
    //final _url = TextEditingController();

    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            // CustomTextFormField(hint: "network image url", funValidator: validateContent(),controller: _url,),
            // TextButton(onPressed: () async {
            //   await t.save(Temp(url: _url.text));
            // }, child: Text("추가")),
            ElevatedButton(
                onPressed: () async {
                  List<XFile>? pickedFile =
                      await ImagePicker().pickMultiImage();
                  uploadImageToStorage(pickedFile);
                  await t.save(Temp(url: _url.text));
                },
                child: Text("추가")),
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: t.temps.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: CachedNetworkImage(
                              imageUrl: t.temps[index].url!)),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                            onPressed: () async {
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
    );
  }
}
