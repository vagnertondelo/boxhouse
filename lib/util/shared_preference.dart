import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

  SharedPreference._() {}

  static Future<String> getData(String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString(key);
    } catch (e) {
    }
    return null;
  }

  static void setData(String key, String mensagem) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, mensagem);
  }

}
