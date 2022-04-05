  import 'package:shared_preferences/shared_preferences.dart';
  
  dynamic setKeyString(key, val) async {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      var _res = prefs.setString(key, val);
      print('$key = : = $val');
      return _res;
  }

  dynamic setKeyBool(key, val) async {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      var _res = prefs.setBool(key, val);
      print('$key = : = $val');
      return _res;
  }

   dynamic getKeyBool(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.getBool(key);
    print('Get Bool Home : $_res');
    return _res;
}


 dynamic getKeyString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.getString(key);
    print('Get String Home : $_res');
    return _res;
}


Future<bool> removeKey(key) async{
   SharedPreferences preferences  =  await SharedPreferences.getInstance();
   return preferences.remove(key);
  }