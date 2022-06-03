import 'dart:convert';

import 'package:intl/intl.dart';

CartaModelResp cartaPruebaToJson(String str) =>
    CartaModelResp.fromJson(json.decode(str));

class CartaModelResp {
  List<DataModel>? data;

  CartaModelResp({
    this.data,
  });

  factory CartaModelResp.fromJson(Map<String, dynamic> json) => CartaModelResp(
        data: (json['Data'] as List).map((e) => modelDataFromJson(e)).toList(),
      );
}

DataModel modelDataFromJson(Map<String, dynamic> json) =>
    DataModel.fromJson(json);

class DataModel {
  final int? idempresa;
  final String? clienteid;
  final String? nombre;
  final String? rfc;
  List<dynamic>? cartaporte;

  DataModel({
    this.idempresa,
    this.clienteid,
    this.nombre,
    this.rfc,
    this.cartaporte,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        idempresa: json['IDCartaPorte'],
        clienteid: json['ClientID'],
        nombre: json['Nombre'],
        rfc: json['RFC'],
        cartaporte: (json['CartaPorte'] as List)
            .map((e) => dayDataFromJson(e))
            .toList(),
      );
}

CartaModel dayDataFromJson(Map<String, dynamic> json) =>
    CartaModel.fromJson(json);

class CartaModel {
  final int? idcartaporte;
  final String? estatus;
  final String? folio;
  final String? nombreclienteproovedor;
  final String? rfcclienteproovedor;
  final int? idclienteproovedor;
  final int? modelovehiculo;
  final String? placasvehiculo;
  final String? tipovehiculo;
  final String? vehiculopermiso;
  final String? aseguradora;
  final String? permisovehiculo;
  final String? polizavehiculo;
  final String? fechainicioviaje;

  CartaModel({
    this.idcartaporte,
    this.estatus,
    this.folio,
    this.nombreclienteproovedor,
    this.rfcclienteproovedor,
    this.idclienteproovedor,
    this.modelovehiculo,
    this.placasvehiculo,
    this.tipovehiculo,
    this.vehiculopermiso,
    this.aseguradora,
    this.permisovehiculo,
    this.polizavehiculo,
    this.fechainicioviaje,
  });

  factory CartaModel.fromJson(Map<String, dynamic> json) => CartaModel(
        idcartaporte: json['IDCartaPorte'],
        estatus: json['Estatus'],
        folio: json['Folio'],
        nombreclienteproovedor: json['NombreClienteProveedor'],
        rfcclienteproovedor: json['RFCClienteProveedor'],
        idclienteproovedor: json['IDClienteProveedor'],
        modelovehiculo: json['ModeloVehiculo'],
        placasvehiculo: json['PlacasVehiculo'],
        tipovehiculo: json['VehiculoTipo'],
        vehiculopermiso: json['VehiculoPermiso'],
        aseguradora: json['AseguradoraVehiculo'],
        permisovehiculo: json['PermisoVehiculo'],
        polizavehiculo: json['PolizaVehiculo'],
        fechainicioviaje: DateFormat("dd-MM-yy")
            .format(DateTime.parse(json['FechaInicioViaje'])),
      );
}
