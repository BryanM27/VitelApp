import 'dart:convert';

CartaModelResp cartaResponseToJson(List str, int id) =>
    CartaModelResp.fromJson((str[id]));

class CartaModelResp {
  List<DataModel>? data;
  List<CartaModel>? cartaporte;

  CartaModelResp({
    this.data,
    this.cartaporte,
  });

  factory CartaModelResp.fromJson(dynamic json) => CartaModelResp(
        data: (json['Data'] as List).map((e) => modelDataFromJson(e)).toList(),
        cartaporte: (json['CartaPorte'] as List)
            .map((e) => dayDataFromJson(e))
            .toList(),
      );
}

CartaModel dayDataFromJson(Map<String, dynamic> json) =>
    CartaModel.fromJson(json);

class CartaModel {
  final int? idcartaporte;

  CartaModel({
    this.idcartaporte,
  });

  factory CartaModel.fromJson(Map<String, dynamic> json) => CartaModel(
        idcartaporte: json['IDCartaPorte'],
      );
}

DataModel modelDataFromJson(Map<String, dynamic> json) =>
    DataModel.fromJson(json);

class DataModel {
  final int? idempresa;
  final String? clienteid;
  final String? nombre;
  final String? rfc;

  DataModel({
    this.idempresa,
    this.clienteid,
    this.nombre,
    this.rfc,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
      idempresa: json['IDCartaPorte'],
      clienteid: json['ClientID'],
      nombre: json['Nombre'],
      rfc: json['RFC']);
}
