import 'package:mercadopago_flutter/models/MPObject.dart';

class MPError extends MPObject{
  String message;
  String error;
  int status;
  List<dynamic> cause; 

  MPError({
    this.message,
    this.error,
    this.status,
    this.cause,
  });

  factory MPError.fromJson(Map<String, dynamic> json) => MPError(
    message: json['message'],
    error: json['error'],
    status: json['status'],
    cause: json['cause'],
  );
}

