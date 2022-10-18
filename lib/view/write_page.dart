import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/model/product.dart';

import '../components/custom_elevated_button.dart';
import '../components/custom_text_form_field.dart';
import '../util/validator_util.dart';


class WritePage extends GetView<ProductController> {
  // List<TextEditingController> _detailControllerList = [];
  // final _mainImageUrl = TextEditingController();
  final ProductController p = Get.put(ProductController());
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _comment = TextEditingController();
  final _price = TextEditingController();
  final _size = TextEditingController();
  final textFormList = <Widget>[].obs;
  final List<bool> _selections = List.generate(6, (index) => false).obs;
  final List<String> categoris = [
    "남성의류",
    "여성의류",
    "남성신발",
    "여성신발",
    "운동화",
    "가방/지갑/악세사리"
  ];
  String? category;

  // WriteController w = Get.put(WriteController());

  // Widget detailTextForm() {
  //   return CustomTextFormField(
  //     controller: _detailControllerList[_detailControllerList.length - 1],
  //     hint: "Network Image Url",
  //     funValidator: validateContent(),
  //   );
  // }
  List<XFile>? pickedFile ;



  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Obx(
            () => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
          key: _formKey,
          child: ListView(
                children: [
                  ToggleButtons(
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
                      category=categoris[index];
                    },
                    selectedColor: Colors.red,
                  ),
                  CustomTextFormField(
                    controller: _name,
                    hint: "상품명",
                    funValidator: validateTitle(),
                  ),
                  CustomTextFormField(
                    controller: _comment,
                    hint: "상품소개",
                    funValidator: validateTitle(),
                  ),
                  CustomTextFormField(
                    controller: _price,
                    hint: "가격",
                    funValidator: validatePrice(),
                  ),
                  // CustomTextFormField(
                  //   controller: _mainImageUrl,
                  //   hint: "Network Image Url (메인이미지)",
                  //   funValidator: validateContent(),
                  // ),
                  CustomTextFormField(
                    controller: _size,
                    hint: "옵션(예: 250/255/260/270) '/' 로구분",
                  ),
                  // Container(
                  //   height: textFormList.length * 60,
                  //   child: ListView.builder(
                  //     itemCount: textFormList.length,
                  //     itemBuilder: (context, index) {
                  //       return Row(
                  //         children: [
                  //           Expanded(child: textFormList[index],flex: 10,),
                  //           Expanded(flex:1,
                  //               child: IconButton(onPressed: (){
                  //                 _detailControllerList.removeAt(index);
                  //                 textFormList.removeAt(index);
                  //               }, icon: Icon(Icons.remove_circle_outline)))
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                  // IconButton(
                  //     onPressed: () {
                  //       _detailControllerList.add(TextEditingController());
                  //       textFormList.add(detailTextForm());
                  //     },
                  //     icon: Icon(Icons.add)),
                  Container(height: 50,),
                  CustomElevatedButton(
                    text: "완료",
                    funPageRoute: () async {
                      if (_formKey.currentState!.validate()) {
                        bool temp=false;
                        for (var element in _selections) {
                          temp=element;
                          if(element) break;
                        }
                        if(!temp) {
                          return showDialog(context: context, builder: (context)=> AlertDialog(title:Text("카테고리 확인"),
                            content: Text("카테고리를 선택하세요."),actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {return Navigator.of(context).pop(); },
                              )
                            ],));
                        }
                        //   List<String> list =
                        //     _detailControllerList.map((e) => e.text).toList();
                        // list.insert(0, _mainImageUrl.text);
                        List<String>size=_size.text.split("/");
                        pickedFile= await ImagePicker().pickMultiImage();
                        List<String> urlList= await p.uploadImageToStorage(pickedFile);
                        await p.save(Product(
                            name: _name.text,
                            comment: _comment.text,
                            price: int.parse(_price.text),
                            mainImageUrl: urlList.first,
                            detailImageUrl: urlList,
                            size: size,
                            category: category
                        ),category!); // 3초 (로딩 그림)
                        context.go("/home/0",);
                      }
                    },
                  ),
                ],
          ),
        ),
              ),
            ),
      ),onLoading: Center(child: Container(height:50,width:50,child: CircularProgressIndicator())) );

  }
}
