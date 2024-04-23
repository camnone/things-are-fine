import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppRepository {
  final SharedPreferences prefs;
  String uidKey = 'uid_key';
  String bidKey = 'bid_key';
  String afInit = 'af_init';
  String link = "link";

  AppRepository({required this.prefs}) {
    _init();
  }

  String? getValue(String key) {
    return prefs.getString(key);
  }

  Future<void> setValue(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<void> _init() async {
    final uid = getValue("uid"), bid = getValue('bid');

    if (uid == null) {
      await setValue(uidKey, Uuid().v4());
    }

    if (bid == null) {
      await setValue(bidKey, Uuid().v4());
    }
  }
}
