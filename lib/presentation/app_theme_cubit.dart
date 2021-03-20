import 'package:chat_app_clean_architecture/data/persistance_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit(this._persistanceStorageRepository) : super(false);

  bool _isDark = false;
  bool get isDark => _isDark;

  final PersistanceStorageRepository _persistanceStorageRepository;

  Future<void> init() async {
    //verify local storage
    _isDark = await _persistanceStorageRepository.isDarkMode();
    emit(_isDark);
  }

  Future<void> updateTheme(bool isDarkMode) async {
    _isDark = isDarkMode;
    await _persistanceStorageRepository.updateDarkMode(isDarkMode);
    emit(_isDark);
  }
}
