// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;
//
// class Test3 extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(onPressed: ()async{
//        List <XFile>? pickedFile = await ImagePicker().pickMultiImage();
//         uploadImageToStorage(pickedFile);
//
//     }, child: Text("dd"));
//   }
//
//   uploadImageToStorage(List<XFile>? pickedFile) async {
//     if(kIsWeb){
//       Reference _reference = FirebaseStorage.instance
//           .ref()
//           .child('images/${Path.basename(pickedFile!.first.path)}');
//       await _reference
//           .putData(
//         await pickedFile.first.readAsBytes(),
//         SettableMetadata(contentType: 'image/jpeg'),
//       )
//           .whenComplete(() async {
//         await _reference.getDownloadURL().then((value) {
//           var uploadedPhotoUrl = value;
//           print(uploadedPhotoUrl);
//         });
//       });
//     }else{print('fff');
// //write a code for android or ios
//     }
//
//   }
//
//
//
// }
