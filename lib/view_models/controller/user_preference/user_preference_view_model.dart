import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTokenId(
  String key,
  String value,
  key2,
  value2,
  key3,
  value3,
  key4,
  value4,
  key5,
  value5,
  key6,value6,
  key7,value7
) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  prefs.setString(key2, value2);
  prefs.setString(key3, value3);
  prefs.setString(key4, value4);
  prefs.setString(key5, value5);
  prefs.setString(key6, value6);
 prefs.setString(key7, value7);
}



Future<void> updateProfile(
  String key,
  String value,
  key2,
  value2,

) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  prefs.setString(key2, value2);
 
}


Future<void> updateProfileImage(
  String key,
  String value,
 

) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);

 
}