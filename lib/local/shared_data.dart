import 'package:food_app/session/key_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  static Future<String?> getPrefarance(String nameKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  static Future<void> savePrefarance(String key, String msg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, msg);
  }
}
