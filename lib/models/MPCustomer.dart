import 'dart:convert';

import 'package:mercadopago_flutter/models/MPCard.dart';
import 'package:mercadopago_flutter/models/MPError.dart';
import 'package:mercadopago_flutter/models/MPObject.dart';

String mpCustomerToJson(MPCustomer data) => json.encode(data.toJson());

class MPCustomer extends MPObject {
  MPAddress address;
  List<MPCard> cards;
  DateTime dateCreated;
  DateTime dateLastUpdated;
  dynamic dateRegistered;
  dynamic defaultAddress;
  String defaultCard;
  dynamic description;
  String email;
  String firstName;
  String id;
  MPIdentification identification;
  String lastName;
  bool liveMode;
  MPMetadata metadata;
  MPPhone phone;

  MPError error;

  MPCustomer({
    this.address,
    this.cards,
    this.dateCreated,
    this.dateLastUpdated,
    this.dateRegistered,
    this.defaultAddress,
    this.defaultCard,
    this.description,
    this.email,
    this.firstName,
    this.id,
    this.identification,
    this.lastName,
    this.liveMode,
    this.metadata,
    this.phone,
    this.error,
  });

  factory MPCustomer.fromJson(Map<String, dynamic> json) => MPCustomer(
        address: json.containsKey('address')
            ? MPAddress.fromJson(json["address"])
            : null,
        cards: json.containsKey('cards')
            ? List<MPCard>.from(json["cards"].map((x) => MPCard.fromJson(x)))
            : [],
        dateCreated: json.containsKey('date_created')
            ? DateTime.parse(json["date_created"])
            : null,
        dateLastUpdated: json.containsKey('date_last_updated')
            ? DateTime.parse(json["date_last_updated"])
            : null,
        dateRegistered: json["date_registered"],
        defaultAddress: json["default_address"],
        defaultCard: json["default_card"],
        description: json["description"],
        email: json["email"],
        firstName: json["first_name"],
        id: json["id"],
        identification: json.containsKey('identification')
            ? MPIdentification.fromJson(json["identification"])
            : null,
        lastName: json["last_name"],
        liveMode: json["live_mode"],
        metadata: json.containsKey('metadata')
            ? MPMetadata.fromJson(json["metadata"])
            : null,
        phone:
            json.containsKey('phone') ? MPPhone.fromJson(json["phone"]) : null,
      );

  factory MPCustomer.fromJsonError(Map<String, dynamic> json) => MPCustomer(
        error: MPError.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        //"default_card": defaultCard ?? null,
        "description": description,
        "email": email,
        "first_name": firstName,
        "identification": identification?.toJson(),
        "last_name": lastName,
        //"metadata": metadata?.toJson(),
        "phone": phone?.toJson(),
      };
}

class MPAddress {
  dynamic id;
  dynamic zipCode;
  dynamic streetName;
  dynamic streetNumber;

  MPAddress({
    this.id,
    this.zipCode,
    this.streetName,
    this.streetNumber,
  });

  factory MPAddress.fromJson(Map<String, dynamic> json) => MPAddress(
        id: json["id"],
        zipCode: json["zip_code"],
        streetName: json["street_name"],
        streetNumber: json["street_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zip_code": zipCode,
        "street_name": streetName,
        "street_number": streetNumber,
      };
}

class MPMetadata {
  MPMetadata();

  factory MPMetadata.fromJson(Map<String, dynamic> json) => MPMetadata();

  Map<String, dynamic> toJson() => {};
}

class MPPhone {
  dynamic areaCode;
  dynamic number;

  MPPhone({
    this.areaCode,
    this.number,
  });

  factory MPPhone.fromJson(Map<String, dynamic> json) => MPPhone(
        areaCode: json["area_code"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "area_code": areaCode,
        "number": number,
      };
}
