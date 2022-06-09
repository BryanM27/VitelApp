import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';

import '../global/constants.dart';

SharedPreference _sharedPreference = SharedPreference();
final prefs = SharedPref.instance;

void DeletePreferences() {
  _sharedPreference.removeOne(ISLICENCIA);
  _sharedPreference.removeOne(TOKENMOVIL);
  _sharedPreference.removeOne(LICENCIA);
  _sharedPreference.removeOne(LOGGEDIN);
  _sharedPreference.removeOne(USERSTATUS);
  _sharedPreference.removeOne(ESTATUS);
  prefs.dataList = false;
  prefs.dateEndToken = '';
  prefs.tokenMovil = '';
}
