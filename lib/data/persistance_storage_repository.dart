abstract class PersistanceStorageRepository {
  Future<bool> isDarkMode();
  Future<void> updateDarkMode(bool isDarkMode);
}
