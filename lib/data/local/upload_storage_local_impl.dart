import 'dart:io';

import 'package:chat_app_clean_architecture/data/upload_storage_repository.dart';

class UploadStorageLocalImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto(File file, String path) async {
    return "https://kb.rspca.org.au/wp-content/uploads/2018/11/golder-retriever-puppy.jpeg";
  }
}
