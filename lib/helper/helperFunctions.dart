import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = 'LOGGEDIN';
  static String sharedPreferenceUserUsernameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';
  static String sharedPreferenceUserProfilePickkey = 'POFILEPICURL';
  static String sharedPreferenceCurrentUserkey = 'CurrentUserId';
  static String sharedPreferenceUpdatedNamekey = 'UpdatedUSERNAMEKEY';
  static String sharedPreferenceVStarUniqueIdkey = '1';
  static String sharedPreferenceVideoId = '0';

  // saving data in sharedPreference
  static Future<bool> saveuserLoggedInSharedPreference(
      bool isuserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isuserLoggedIn);
  }

  static Future saveuserCurrentUserIdSharedPreference(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceCurrentUserkey, id);
  }
  static Future saveuserVideoId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setInt(sharedPreferenceVideoId, id);
  }




  static Future savePreferenceVStarUniqueIdkey(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setInt(sharedPreferenceVStarUniqueIdkey, id);
  }

  static Future saveuserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceUserUsernameKey, userName);
  }
  static Future saveuserUpdatedNameSharedPreference(String userUpdatedName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceUpdatedNamekey, userUpdatedName);
  }
  static Future saveuserProfilepicSharedPreference(String picUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceUserProfilePickkey, picUrl);
  }

  static Future saveuserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

//getting data
  static Future<bool> getuserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getuserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString(sharedPreferenceUserUsernameKey);
  }

  static Future<String> getuserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getuserProfilePicSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString(sharedPreferenceUserProfilePickkey);
  }
  static Future<String> getCurrentUserIdSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString(sharedPreferenceCurrentUserkey);
  }
  static Future<String> getUpdateNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString(sharedPreferenceUpdatedNamekey);
  }
  static Future<int> getVStarUniqueIdkey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getInt(sharedPreferenceVStarUniqueIdkey);
  }
  static Future<int> getVedioID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getInt(sharedPreferenceVideoId);
  }
}
