// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPref {
//   SharedPref._();
//   static SharedPref _instance = new SharedPref._();

//   static SharedPref get instance => _instance;

//   static SharedPreferences? _prefs;

//   static void init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   bool? get validarLicencia => _prefs!.getBool('validarLicencia');

//   set validarLicencia(bool? isvalidate) {
//     _prefs!.setBool('validarLicencia', isvalidate ?? false);
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref _instance = SharedPref._internal();

  static SharedPreferences? _prefs;

  SharedPref._internal();

  static SharedPref get instance => _instance;

  static void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

//LICENCIA
  bool? get validarLicencia => _prefs!.getBool('validarLicencia');

  set validarLicencia(bool? isvalidate) {
    _prefs!.setBool('validarLicencia', isvalidate ?? false);
  }

  String? get licenciaUser => _prefs!.getString('licenciaUser');

  set licenciaUser(String? islicenciaUser) {
    _prefs!.setString('licenciaUser', islicenciaUser ?? 'NO HAY INFORMACION');
  }

  // TOKEN
  String? get tokenMovil => _prefs!.getString('tokenMovil');

  set tokenMovil(String? tokenMovilresp) {
    _prefs!.setString('tokenMovil', tokenMovilresp ?? 'NO HAY INFORMACION');
  }

  String? get userEmail => _prefs!.getString('userEmail');

  set userEmail(String? userEmailget) {
    _prefs!.setString('userEmail', userEmailget ?? '');
  }

  // DataListView
  bool? get dataList => _prefs!.getBool('dataList');

  set dataList(bool? isdataList) {
    _prefs!.setBool('dataList', isdataList ?? false);
  }
}
