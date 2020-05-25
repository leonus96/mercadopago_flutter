import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

const MP_URL = 'api.mercadopago.com';

class MPServices {
  final credentials;

  MPServices({@required this.credentials});

  Future _get(Uri uri) async {
    http.Response response = await http.get(uri);
    return jsonDecode(response.body);
  }

  Future _post(Uri uri, String body) async {
    http.Response response = await http.post(uri, body: body);
    return jsonDecode(response.body);
  }

  Future _delete(Uri uri) async {
    http.Response response = await http.delete(uri);
    return jsonDecode(response.body);
  }

  // Customers:
  Future getCustomer(String customerId) async {
    Uri uri = Uri.https(MP_URL, '/v1/customers/$customerId',
        {'access_token': credentials.accessToken});
    return _get(uri);
  }

  Future searchCustomer(Map<String, String> searchParams) async {
    searchParams['access_token'] = credentials.accessToken;
    Uri uri = Uri.https(MP_URL, '/v1/customers/search', searchParams);
    return _get(uri);
  }

  Future createCustomer(String customerData) async {
    Uri uri = Uri.https(
        MP_URL, '/v1/customers', {'access_token': credentials.accessToken});
    return _post(uri, customerData);
  }

  Future getCardsOfCustomers(String customerId) {
    Uri uri = Uri.https(MP_URL, '/v1/customers/$customerId/cards',
        {'access_token': credentials.accessToken});
    return _get(uri);
  }

  Future createCard(String cardData) {
    Uri uri = Uri.https(
        MP_URL, '/v1/card_tokens', {'access_token': credentials.accessToken});
    return _post(uri, cardData);
  }

  Future linkCardWithCustomer(String customerId, String cardToken) {
    Uri uri = Uri.https(MP_URL, '/v1/customers/$customerId/cards',
        {'access_token': credentials.accessToken});

    return _post(uri, jsonEncode({'token': cardToken}));
  }

  Future getCard(String customerId, String cardId) {
    Uri uri = Uri.https(MP_URL, '/v1/customers/$customerId/cards/$cardId',
        {'access_token': credentials.accessToken});
    return _get(uri);
  }

  Future deleteCard(String customerId, String cardId) {
    Uri uri = Uri.https(MP_URL, '/v1/customers/$customerId/cards/$cardId',
        {'access_token': credentials.accessToken});
    return _delete(uri);
  }

  Future getCardToken(String cardData) {
    Uri uri = Uri.https(
        MP_URL, '/v1/card_tokens', {'public_key': credentials.publicKey});
    return _post(uri, cardData);
  }

  Future createPay(String payData) {
    Uri uri = Uri.https(
      MP_URL,
      '/v1/payments',
      {'access_token': credentials.accessToken},
    );
    return _post(uri, payData);
  }
}
