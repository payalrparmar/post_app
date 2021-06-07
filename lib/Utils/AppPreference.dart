import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  /*set profile value in SharedPreferences*/
  static Future<String> getProfilePic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("profilePic") ?? '';
  }

  /*get profile value form SharedPreferences*/
  static Future<String> setProfilePic(String profilePic) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profilePic", profilePic);
  }
}
