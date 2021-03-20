import 'dart:io';

import 'package:chat_app_clean_architecture/data/image_picker_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerImpl extends ImagePickerRepository {
  @override
  Future<File> pickImage() async {
    final picker = ImagePicker();
    final pickerFile =
        await picker.getImage(source: ImageSource.gallery, maxWidth: 400);
    return File(pickerFile.path);
  }
}
