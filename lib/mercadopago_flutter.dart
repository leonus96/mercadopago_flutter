library mercadopago_flutter;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mercadopago_flutter/models/MPCredentials.dart';
import 'package:mercadopago_flutter/models/MPCustomer.dart';
import 'package:mercadopago_flutter/models/MPPay.dart';
import 'package:mercadopago_flutter/mp_services.dart';

import 'models/MPCard.dart';

class MercadoPagoFlutter {
  MPCredentials _credentials;
  MPServices _services;

  MercadoPagoFlutter({
    @required String publicKey,
    @required String accessToken,
  }) {
    _credentials =
        MPCredentials(publicKey: publicKey, accessToken: accessToken);
    _services = MPServices(credentials: _credentials);
  }

  Future<MPCustomer> getCustomer(String customerId) async {
    Map<String, dynamic> response = await _services.getCustomer(customerId);
    if (response.containsKey('error')) {
      return MPCustomer.fromJsonError(response);
    }
    return MPCustomer.fromJson(response);
  }

  Future<List<MPCustomer>> searchCustomer(
      Map<String, String> searchParams) async {
    Map<String, dynamic> response =
        await _services.searchCustomer(searchParams);
    if (response.containsKey('error')) {
      return [MPCustomer.fromJsonError(response)];
    }
    List<MPCustomer> customers = [];
    for (Map<String, dynamic> customerData in response['results']) {
      customers.add(MPCustomer.fromJson(customerData));
    }
    return customers;
  }

  Future<MPCustomer> createCustomer({
    @required String email,
    @required String firstName,
    @required String lastName,
    @required MPPhone phone,
    @required MPAddress address,
    @required String description,
  }) async {
    MPCustomer customer = MPCustomer(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      address: address,
      description: description,
    );
    Map<String, dynamic> response =
        await _services.createCustomer(mpCustomerToJson(customer));
    if (response.containsKey('error')) {
      return MPCustomer.fromJsonError(response);
    }
    return MPCustomer.fromJson(response);
  }

  Future<List<MPCard>> getCardsOfUser(String customerId) async {
    dynamic response = await _services.getCardsOfCustomers(customerId);
    if (response.containsKey('error')) {
      return [MPCard.fromJsonError(response)];
    }
    List<MPCard> cards = [];
    for (Map<String, dynamic> customerData in response) {
      cards.add(MPCard.fromJson(customerData));
    }
    return cards;
  }

  Future<MPCard> createCard({
    @required String securityCode,
    @required String cardNumber,
    @required int expirationMonth,
    @required int expirationYear,
    @required MPCardholder cardHolder,
  }) async {
    MPCard card = MPCard(
        securityCode: securityCode,
        cardNumber: cardNumber,
        expirationMonth: expirationMonth,
        expirationYear: expirationYear,
        cardholder: cardHolder);

    Map<String, dynamic> response =
        await _services.createCard(mpCardToJson(card));
    if (response.containsKey('error')) {
      return MPCard.fromJsonError(response);
    }
    return MPCard.fromJson(response);
  }

  Future<MPCard> linkCardWithCustomer({
    @required MPCustomer customer,
    @required MPCard card,
  }) async {
    Map<String, dynamic> response =
        await _services.linkCardWithCustomer(customer.id, card.id);
    if (response.containsKey('error')) {
      return MPCard.fromJsonError(response);
    }
    return MPCard.fromJson(response);
  }

  Future<MPCard> getCard(
      {@required String customerId, @required String cardId}) async {
    Map<String, dynamic> response = await _services.getCard(customerId, cardId);
    if (response.containsKey('error')) {
      return MPCard.fromJsonError(response);
    }
    return MPCard.fromJson(response);
  }

  Future<MPCard> deleteCard(
      {@required String customerId, @required String cardId}) async {
    Map<String, dynamic> response = await _services.getCard(customerId, cardId);
    if (response.containsKey('error')) {
      return MPCard.fromJsonError(response);
    }
    return MPCard.fromJson(response);
  }

  Future<String> getCardToken({
    @required String ccv,
    @required String cardId,
  }) async {
    var request = {
      'card_id': cardId,
      'security_code': ccv,
    };
    Map<String, dynamic> response =
        await _services.getCardToken(jsonEncode(request));
    if (response.containsKey('error')) {
      return 'error';
    }
    return response['id'];
  }

  Future createPay({
    @required String token,
    int installments: 1,
    @required double transactionAmount,
    String description: '',
    @required String paymentMethodId,
    @required MPCustomer customer,
    String externalReference: '',
    bool capture: true,
  }) async {
    var request = {
      "token": token,
      'installments': installments,
      'transaction_amount': transactionAmount,
      'description': description,
      'payment_method_id': paymentMethodId,
      'payer': {
        'id': customer.id,
        'email': customer.email,
      },
      'external_reference': externalReference,
      'capture': capture,
    };

    Map<String, dynamic> response =
        await _services.createPay(jsonEncode(request));
    if (response.containsKey('error')) {
      return MPPay.fromJsonError(response);
    }
    return MPPay.fromJson(response);
  }
}
