import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda/controller/product_controller.dart';
import 'package:panda/model/product.dart';
import 'package:panda/view/detail_page.dart';
import 'package:panda/view/temp_page.dart';

import '../components/custom_elevated_button.dart';
import '../components/custom_text_form_field.dart';
import '../util/validator_util.dart';
import 'home_page.dart';

class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _comment = TextEditingController();
  final _price = TextEditingController();
  final _mainImageUrl = TextEditingController();
  final _size = TextEditingController();
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

     ProductController p =Get.find();

     _name.text = p.product.value.name!;
     _comment.text = p.product.value.comment!;
     _price.text = p.product.value.price!.toString();
     category=p.product.value.category;
    _mainImageUrl.text = p.product.value.mainImageUrl!;

    for(int i = 0; i<p.product.value.detailImageUrl!.length;i++){
      _detailControllerList.add(TextEditingController());
      _detailControllerList[i].text=p.product.value.detailImageUrl![i];
      textFormList.add(detailTextForm());
    }
    _detailControllerList.removeAt(0);
    textFormList.removeAt(0); // 그냥 메인 유알엘 지우고 하나로 다 관리할껄..

     for(int i = 0; i<categoris.length;i++){
       if(categoris[i]==p.product.value.category) {
         _selections[i]=true;
         break;
       }
     }
     String temp="";
     List<dynamic>? size =p.product.value.size;
     for(int i = 0 ; i<size!.length;i++){
       temp=temp+size[i]+"/";
     }
     _size.text=temp;

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
                CustomTextFormField(
                  controller: _size,
                  hint: "사이즈(예: 250/255/260/270) '/' 로구분",
                ),
                Container(
                  height: textFormList.length * 60,
                  child: ListView.builder(
                    itemCount: textFormList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(child: textFormList[index],flex:10),
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
                  text: "수정하기",
                  funPageRoute: () async {
                    if (_formKey.currentState!.validate()) {
                      List<String> list =
                      _detailControllerList.map((e) => e.text).toList();
                      list.insert(0, _mainImageUrl.text);
                      List<String> size=_size.text.split("/");
                      await Get.find<ProductController>().updateProduct(Product(
                          id: p.product.value.id,
                          name: _name.text,
                          comment: _comment.text,
                          price: int.parse(_price.text),
                          mainImageUrl: _mainImageUrl.text,
                          detailImageUrl: list,
                          size: size,
                          category: category
                      )); // 3초 (로딩 그림)
                      await Get.off(() => TempPage());
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
