import 'dart:convert';

import 'package:mercadopago_flutter/models/MPCustomer.dart';
import 'package:mercadopago_flutter/models/MPError.dart';
import 'package:mercadopago_flutter/models/MPObject.dart';

String mpPayToJson(MPPay data) => json.encode(data.toJson());

class MPPay extends MPObject {
  int id;
  DateTime dateCreated;
  DateTime dateApproved;
  DateTime dateLastUpdated;
  dynamic dateOfExpiration;
  DateTime moneyReleaseDate;
  String operationType;
  dynamic issuerId;
  String paymentMethodId;
  String paymentTypeId;
  String status;
  String statusDetail;
  String currencyId;
  String description;
  bool liveMode;
  dynamic sponsorId;
  dynamic authorizationCode;
  dynamic moneyReleaseSchema;
  dynamic counterCurrency;
  int collectorId;
  MPCustomer payer;
  dynamic externalReference;
  double transactionAmount;
  double transactionAmountRefunded;
  int couponAmount;
  dynamic differentialPricingId;
  dynamic deductionSchema;
  TransactionDetails transactionDetails;
  List<dynamic> feeDetails;
  bool captured;
  bool binaryMode;
  dynamic callForAuthorizeId;
  dynamic statementDescriptor;
  int installments;
  dynamic notificationUrl;
  List<dynamic> refunds;
  dynamic processingMode;
  dynamic merchantAccountId;
  dynamic acquirer;
  dynamic merchantNumber;
  List<dynamic> acquirerReconciliation;

  String token;
  double capture;

  MPError error;

  MPPay({
    this.id,
    this.dateCreated,
    this.dateApproved,
    this.dateLastUpdated,
    this.dateOfExpiration,
    this.moneyReleaseDate,
    this.operationType,
    this.issuerId,
    this.paymentMethodId,
    this.paymentTypeId,
    this.status,
    this.statusDetail,
    this.currencyId,
    this.description,
    this.liveMode,
    this.sponsorId,
    this.authorizationCode,
    this.moneyReleaseSchema,
    this.counterCurrency,
    this.collectorId,
    this.payer,
    this.externalReference,
    this.transactionAmount,
    this.transactionAmountRefunded,
    this.couponAmount,
    this.differentialPricingId,
    this.deductionSchema,
    this.transactionDetails,
    this.feeDetails,
    this.captured,
    this.binaryMode,
    this.callForAuthorizeId,
    this.statementDescriptor,
    this.installments,
    this.notificationUrl,
    this.refunds,
    this.processingMode,
    this.merchantAccountId,
    this.acquirer,
    this.merchantNumber,
    this.acquirerReconciliation,
    this.token,
    this.error,
  });

  factory MPPay.fromJson(Map<String, dynamic> json) => MPPay(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateApproved: DateTime.parse(json["date_approved"]),
        dateLastUpdated: DateTime.parse(json["date_last_updated"]),
        dateOfExpiration: json["date_of_expiration"],
        moneyReleaseDate: DateTime.parse(json["money_release_date"]),
        operationType: json["operation_type"],
        issuerId: json["issuer_id"],
        paymentMethodId: json["payment_method_id"],
        paymentTypeId: json["payment_type_id"],
        status: json["status"],
        statusDetail: json["status_detail"],
        currencyId: json["currency_id"],
        description: json["description"],
        liveMode: json["live_mode"],
        sponsorId: json["sponsor_id"],
        authorizationCode: json["authorization_code"],
        moneyReleaseSchema: json["money_release_schema"],
        counterCurrency: json["counter_currency"],
        collectorId: json["collector_id"],
        payer: MPCustomer.fromJson(json["payer"]),
        externalReference: json["external_reference"],
        transactionAmount: double.parse(json["transaction_amount"].toString()),
        transactionAmountRefunded:
            double.parse(json["transaction_amount_refunded"].toString()),
        couponAmount: json["coupon_amount"],
        differentialPricingId: json["differential_pricing_id"],
        deductionSchema: json["deduction_schema"],
        transactionDetails:
            TransactionDetails.fromJson(json["transaction_details"]),
        feeDetails: List<dynamic>.from(json["fee_details"].map((x) => x)),
        captured: json["captured"],
        binaryMode: json["binary_mode"],
        callForAuthorizeId: json["call_for_authorize_id"],
        statementDescriptor: json["statement_descriptor"],
        installments: json["installments"],
        notificationUrl: json["notification_url"],
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        processingMode: json["processing_mode"],
        merchantAccountId: json["merchant_account_id"],
        acquirer: json["acquirer"],
        merchantNumber: json["merchant_number"],
        acquirerReconciliation:
            List<dynamic>.from(json["acquirer_reconciliation"].map((x) => x)),
      );

  factory MPPay.fromJsonError(Map<String, dynamic> json) =>
      MPPay(error: MPError.fromJson(json));
  Map<String, dynamic> toJson() => {
        "description": description,
        "payer": payer.toJson(),
        "payment_method_id": paymentMethodId,
        "external_reference": externalReference,
        "transaction_amount": transactionAmount,
        "captured": captured,
        "installments": installments,
        "notification_url": notificationUrl,
        "token": token,
      };
}

class TransactionDetails {
  double netReceivedAmount;
  double totalPaidAmount;
  double overpaidAmount;
  dynamic externalResourceUrl;
  double installmentAmount;
  dynamic financialInstitution;
  dynamic paymentMethodReferenceId;
  dynamic payableDeferralPeriod;
  dynamic acquirerReference;

  TransactionDetails({
    this.netReceivedAmount,
    this.totalPaidAmount,
    this.overpaidAmount,
    this.externalResourceUrl,
    this.installmentAmount,
    this.financialInstitution,
    this.paymentMethodReferenceId,
    this.payableDeferralPeriod,
    this.acquirerReference,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        netReceivedAmount: double.parse(json["net_received_amount"].toString()),
        totalPaidAmount: double.parse(json["total_paid_amount"].toString()),
        overpaidAmount: double.parse(json["overpaid_amount"].toString()),
        externalResourceUrl: json["external_resource_url"],
        installmentAmount: double.parse(json["installment_amount"].toString()),
        financialInstitution: json["financial_institution"],
        paymentMethodReferenceId: json["payment_method_reference_id"],
        payableDeferralPeriod: json["payable_deferral_period"],
        acquirerReference: json["acquirer_reference"],
      );

  Map<String, dynamic> toJson() => {
        "net_received_amount": netReceivedAmount,
        "total_paid_amount": totalPaidAmount,
        "overpaid_amount": overpaidAmount,
        "external_resource_url": externalResourceUrl,
        "installment_amount": installmentAmount,
        "financial_institution": financialInstitution,
        "payment_method_reference_id": paymentMethodReferenceId,
        "payable_deferral_period": payableDeferralPeriod,
        "acquirer_reference": acquirerReference,
      };
}
