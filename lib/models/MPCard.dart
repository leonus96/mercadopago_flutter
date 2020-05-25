import 'dart:convert';

import 'package:mercadopago_flutter/models/MPError.dart';
import 'package:mercadopago_flutter/models/MPObject.dart';

String mpCardToJson(MPCard data) => json.encode(data.toJson());

class MPCard extends MPObject {
  MPCardholder cardholder;
  String customerId;
  DateTime dateCreated;
  DateTime dateLastUpdated;
  int expirationMonth;
  int expirationYear;
  String firstSixDigits;
  String id;
  Issuer issuer;
  String lastFourDigits;
  PaymentMethod paymentMethod;
  SecurityCode securityCodeInfo;
  String userId;

  String cardNumber;
  String securityCode;

  MPError error;

  MPCard({
    this.cardholder,
    this.customerId,
    this.dateCreated,
    this.dateLastUpdated,
    this.expirationMonth,
    this.expirationYear,
    this.firstSixDigits,
    this.id,
    this.issuer,
    this.lastFourDigits,
    this.paymentMethod,
    this.securityCodeInfo,
    this.userId,
    this.securityCode,
    this.cardNumber,
    this.error,
  });

  factory MPCard.fromJson(Map<String, dynamic> json) => MPCard(
        cardholder: MPCardholder.fromJson(json["cardholder"]),
        customerId: json["customer_id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateLastUpdated: DateTime.parse(json["date_last_updated"]),
        expirationMonth: json["expiration_month"],
        expirationYear: json["expiration_year"],
        firstSixDigits: json["first_six_digits"],
        id: json["id"],
        issuer:
            json.containsKey('issuer') ? Issuer.fromJson(json["issuer"]) : null,
        lastFourDigits: json["last_four_digits"],
        paymentMethod: json.containsKey('payment_method')
            ? PaymentMethod.fromJson(json["payment_method"])
            : null,
        securityCodeInfo: json.containsKey('security_code')
            ? SecurityCode.fromJson(json["security_code"])
            : null,
        userId: json["user_id"],
      );

  factory MPCard.fromJsonError(Map<String, dynamic> json) =>
      MPCard(error: MPError.fromJson(json));

  Map<String, dynamic> toJson() => {
        "cardholder": cardholder.toJson(),
        //"customer_id": customerId,
        //"date_created": dateCreated.toIso8601String(),
        //"date_last_updated": dateLastUpdated.toIso8601String(),
        "expiration_month": expirationMonth,
        "expiration_year": expirationYear,
        //"first_six_digits": firstSixDigits,
        //"id": id,
        //"issuer": issuer.toJson(),
        //"last_four_digits": lastFourDigits,
        //"payment_method": paymentMethod.toJson(),
        //"user_id": userId,

        "security_code": this.securityCode,
        "card_number": this.cardNumber,
      };
}

class PaymentMethod {
  String id;
  String name;
  String paymentTypeId;
  String thumbnail;
  String secureThumbnail;

  PaymentMethod({
    this.id,
    this.name,
    this.paymentTypeId,
    this.thumbnail,
    this.secureThumbnail,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        paymentTypeId: json["payment_type_id"],
        thumbnail: json["thumbnail"],
        secureThumbnail: json["secure_thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "payment_type_id": paymentTypeId,
        "thumbnail": thumbnail,
        "secure_thumbnail": secureThumbnail,
      };
}

class SecurityCode {
  int length;
  String cardLocation;

  SecurityCode({
    this.length,
    this.cardLocation,
  });

  factory SecurityCode.fromJson(Map<String, dynamic> json) => SecurityCode(
        length: json["length"],
        cardLocation: json["card_location"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "card_location": cardLocation,
      };
}

class MPCardholder {
  String name;
  MPIdentification identification;

  MPCardholder({
    this.name,
    this.identification,
  });

  factory MPCardholder.fromJson(Map<String, dynamic> json) => MPCardholder(
        name: json["name"],
        identification: MPIdentification.fromJson(json["identification"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "identification": identification.toJson(),
      };
}

class MPIdentification {
  String number;
  String type;

  MPIdentification({
    this.number,
    this.type,
  });

  factory MPIdentification.fromJson(Map<String, dynamic> json) =>
      MPIdentification(
        number: json["number"] == null ? null : json["number"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "type": type == null ? null : type,
      };
}

class Issuer {
  int id;
  String name;

  Issuer({
    this.id,
    this.name,
  });

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
