import 'package:dio/dio.dart';
import 'package:vitel_chat/src/models/country.dart';

class CountryService {
  final _dio = new Dio();

  Future getCountryByName(String name) async {
    try {
      final url = 'https://restcountries.com/v3.1/name/japan';
      final resp = await _dio.get(url);

      final List<dynamic> countryList = resp.data;

      return countryList.map((obj) => Country.fromJson(obj)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
