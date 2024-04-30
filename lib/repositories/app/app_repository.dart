import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AppRepository {
  final SharedPreferences prefs;
  String uidKey = 'uid_key';
  String bidKey = 'bid_key';
  String afInit = 'af_init';
  String link = "link";
  String afUid = 'af_uid';
  String fmcToken = 'fmc_token';
  String rejectTime = 'reject_time';
  String pushUrl = 'push_url';
  String redirectUrl = 'redirect_url';

  AppRepository({required this.prefs}) {
    _init();
  }

  String? getValue(String key) {
    return prefs.getString(key);
  }

  Future<void> setValue(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<void> clearKeyValue(String key) async {
    await prefs.remove(key);
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
