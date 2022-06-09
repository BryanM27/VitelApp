import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref _instance = SharedPref._internal();

  static SharedPreferences? _prefs;

  SharedPref._internal();

  static SharedPref get instance => _instance;

  static void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

//Login
  bool? get firstLogin => _prefs!.getBool('firstLogin');

  set firstLogin(bool? isfirstLogin) {
    _prefs!.setBool('firstLogin', isfirstLogin ?? false);
  }

  int? get pageSelect => _prefs!.getInt('pageSelect');

  set pageSelect(int? pageSelected) {
    _prefs!.setInt('pageSlect', pageSelected ?? 0);
  }

  bool? get rememberUser => _prefs!.getBool('rememberUser');

  set rememberUser(bool? isrememberUser) {
    _prefs!.setBool('rememberUser', isrememberUser ?? false);
  }

  String? get dateEndToken => _prefs!.getString('dateEndToken');

  set dateEndToken(String? DateEndToken) {
    _prefs!.setString('dateEndToken', DateEndToken ?? '');
  }

  bool? get logged => _prefs!.getBool('logged');

  set logged(bool? islogged) {
    _prefs!.setBool('logged', islogged ?? false);
  }

//LICENCIA
  bool? get validarLicencia => _prefs!.getBool('validarLicencia');

  set validarLicencia(bool? isvalidate) {
    _prefs!.setBool('validarLicencia', isvalidate ?? false);
  }

  String? get licenciaUser => _prefs!.getString('licenciaUser');

  set licenciaUser(String? islicenciaUser) {
    _prefs!.setString('licenciaUser', islicenciaUser ?? '');
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

  //DOWNLOAD
  String? get idClient => _prefs!.getString('idClient');

  set idClient(String? IDclient) {
    _prefs!.setString('idClient', IDclient ?? '');
  }

  int? get idCartaPorte => _prefs!.getInt('idCartaPorte');

  set idCartaPorte(int? IDCartaPorte) {
    _prefs!.setInt('idCartaPorte', IDCartaPorte ?? 0);
  }

  int? get idEmpresa => _prefs!.getInt('idEmpresa');

  set idEmpresa(int? IDempresa) {
    _prefs!.setInt('idEmpresa', IDempresa ?? 0);
  }

  //CONTADORES CARTAPORTE
  int? get totalEmpresas => _prefs!.getInt('totalEmpresas');

  set totalEmpresas(int? TotalEmpresas) {
    _prefs!.setInt('totalEmpresas', TotalEmpresas ?? 0);
  }

  int? get totalCartaPortes => _prefs!.getInt('totalCartaPortes');

  set totalCartaPortes(int? TotalCartaPortes) {
    _prefs!.setInt('totalCartaPortes', TotalCartaPortes ?? 0);
  }
}
