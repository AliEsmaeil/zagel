import 'dart:io';

import 'package:image_picker/image_picker.dart';

final class MyImagePicker{

   static XFile? file;
   static ImagePicker picker = ImagePicker();

  static Future<File?> pickImage(ImageSource source)async{

    file = await picker.pickImage(source: source);

     return (file != null)? File(file!.path) : null;
  }
}