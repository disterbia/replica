import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/model/product.dart';

import '../components/custom_elevated_button.dart';
import '../components/custom_text_form_field.dart';
import '../util/validator_util.dart';
import 'temp_page.dart';

class WritePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _comment = TextEditingController();
  final _price = TextEditingController();
  final _mainImageUrl = TextEditingController();
  List<TextEditingController> _detailControllerList = [];
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

  Widget detailTextForm() {
    return CustomTextFormField(
      controller: _detailControllerList[_detailControllerList.length - 1],
      hint: "Network Image Url",
      funValidator: validateContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Form(
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
                  funValidator: validateTitle(),
                ),
                CustomTextFormField(
                  controller: _mainImageUrl,
                  hint: "Network Image Url (메인이미지)",
                  funValidator: validateContent(),
                ),
                Container(
                  height: textFormList.length * 60,
                  child: ListView.builder(
                    itemCount: textFormList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(child: textFormList[index],flex: 10,),
                          Expanded(flex:1,
                              child: IconButton(onPressed: (){
                                _detailControllerList.removeAt(index);
                                textFormList.removeAt(index);
                              }, icon: Icon(Icons.remove_circle_outline)))
                        ],
                      );
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _detailControllerList.add(TextEditingController());
                      textFormList.add(detailTextForm());
                    },
                    icon: Icon(Icons.add)),
                Container(height: 300,),
                CustomElevatedButton(
                  text: "글쓰기",
                  funPageRoute: () async {
                    if (_formKey.currentState!.validate()) {
                      List<String> list =
                          _detailControllerList.map((e) => e.text).toList();
                      list.insert(0, _mainImageUrl.text);
                      await Get.find<ProductController>().save(Product(
                        name: _name.text,
                        comment: _comment.text,
                        price: _price.text,
                        mainImageUrl: _mainImageUrl.text,
                        detailImageUrl: list,
                        category: category
                      )); // 3초 (로딩 그림)
                      Get.off(() => TempPage());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
