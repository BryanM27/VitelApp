import 'dart:convert';

CartaPorteGet cartaporteToJson(String str) =>
    CartaPorteGet.fromJson(json.decode(str));

class CartaPorteGet {
  final int? idempresa;
  final String? clientID;
  final String? nombre;
  final String? rfc;

  CartaPorteGet({
    this.idempresa,
    this.clientID,
    this.nombre,
    this.rfc,
  });

  factory CartaPorteGet.fromJson(dynamic json) => new CartaPorteGet(
      idempresa: json['IDEmpresa'] as int,
      clientID: json['ClientID'] as String,
      nombre: json['Nombre'] as String,
      rfc: json['RFC'] as String);
}
