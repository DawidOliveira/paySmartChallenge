import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static Future<void> deleteData(String key) async {
    final ps = await _newInstance();

    await ps.remove(key);
  }

  static Future<String?> getData(String key) async {
    final ps = await _newInstance();

    return ps.getString(key);
  }

  static Future<List<String>?> getListData(String key) async {
    final ps = await _newInstance();

    return ps.getStringList(key);
  }

  static Future<String?> saveData(String key, {required String data}) async {
    final ps = await _newInstance();

    await ps.setString(key, data);
    return getData(key);
  }

  static Future<List<String>?> saveListData(String key,
      {required List<String> data}) async {
    final ps = await _newInstance();

    await ps.setStringList(key, data);
  }

  static Future<List<String>?> deleteItemList(String key,
      {required String value}) async {
    final list = await getListData(key)
      ?..removeWhere(
          (element) => element.toLowerCase().contains(value.toLowerCase()));
    await saveListData(key, data: list!);
    return list;
  }

  static Future<SharedPreferences> _newInstance() async {
    final ps = await SharedPreferences.getInstance();
    return ps;
  }
}
