import 'package:chat_app_clean_architecture/data/persistance_storage_repository.dart';

class PersistanceStorageLocalImpl extends PersistanceStorageRepository {
  @override
  Future<void> updateDarkMode(bool isDarkMode) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return;
  }

  @override
  Future<bool> isDarkMode() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return false;
  }
}
