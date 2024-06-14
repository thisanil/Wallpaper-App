import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  String token = "token";

  Future<void> setToken(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, data);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(token) ?? "";
    return data;
  }
}
