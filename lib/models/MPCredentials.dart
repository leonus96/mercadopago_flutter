import 'package:flutter/material.dart';
import 'package:mercadopago_flutter/models/MPObject.dart';

class MPCredentials extends MPObject {
  final String publicKey;
  final String accessToken;
  MPCredentials({@required this.publicKey, @required this.accessToken});
}
