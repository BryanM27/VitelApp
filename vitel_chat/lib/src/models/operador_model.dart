// ignore: file_names
import 'dart:convert';

String operadormodelToJson(OperadorModel data) => json.encode(data.toJson());

class OperadorModel {
  final String? rfc;
  final String? clave;
  final String? nombre;

  OperadorModel({
    this.rfc,
    this.nombre,
    this.clave,
  });

  Map<String, dynamic> toJson() => {
        "RFC": rfc,
        "Nombre": nombre,
        "Clave": clave,
      };
}
