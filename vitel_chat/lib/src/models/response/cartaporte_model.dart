import 'dart:convert';

CartaModelResp cartaResponseToJson(List str) => CartaModelResp.fromJson(str);

class CartaModelResp {
  final int? idempresa;
  final String? clienteid;
  final String? nombre;
  final String? rfc;
  List<DayModel>? cartaporte;
  CartaModelResp({
    this.idempresa,
    this.clienteid,
    this.nombre,
    this.rfc,
    this.cartaporte,
  });

  factory CartaModelResp.fromJson(dynamic json) => new CartaModelResp(
        idempresa: json['IDempresa'],
        clienteid: json['Clienteid'],
        nombre: json['Nombre'],
        rfc: json['RFC'],
        cartaporte: (json['CartaPorte'] as List)
            .map((e) => dayDataFromJson(e))
            .toList(),
      );
}

DayModel dayDataFromJson(Map<String, dynamic> json) => DayModel.fromJson(json);

class DayModel {
  final int? idcartaporte;

  DayModel({
    this.idcartaporte,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) => new DayModel(
        idcartaporte: json['IDCartaPorte'],
      );
}
