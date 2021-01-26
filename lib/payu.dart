import 'package:flutter/cupertino.dart';

/// https://payumobile.gitbook.io/sdk-integration/android/payucheckoutpro/build-the-payment-params
class Payu {
  /// Total transaction amount Can not be null or empty and should be valid double stringified eg, “100.0”
  @required
  String amount;

  /// Information about product Can not be null or empty
  @required
  String productInfo;

  /// Merchant key received from PayU Can not be null or empty
  @required
  String merchantKey;

  /// Merchant salt received from PayU Can be filled in, if not null will calculate the hash locally
  String merchantSalt;

  /// Environment of SDK. Set to true for Production else false Should be a Boolean value. Default value is true
  bool isProduction = true;

  /// Customer’s phone number Should be of 10 digits
  String phone;

  /// It should be unique for each transaction Should be unique for each transaction
  @required
  String transactionId;

  /// Customer’s first name Can not be null or empty
  @required
  String firstName;

  /// Customer’s email id Can not be null or empty
  @required
  String email;

  /// When the transaction is successful, PayU will load this url and pass transaction response Can not be null or empty
  @required
  String surl;

  /// When the transaction is a failure, PayU will load this url and pass transaction response Can not be null or empty
  @required
  String furl;

  /// This is used for the store card feature. PayU will store cards corresponding to passed user credentials and similarly, user credentials will be used to access previously saved cards Should be a unique value Format : <merchantKey>:<userId> Here,  UserId is any id/email/phone number to uniquely identify the user
  String userCredential;

  /// https://payumobile.gitbook.io/sdk-integration/android/payucheckoutpro/build-the-payment-params/additional-params
  String udf1 = 'udf1';
  String udf2 = 'udf2';
  String udf3 = 'udf3';
  String udf4 = 'udf4';
  String udf5 = 'udf5';

  /// Do not deprecated generate hash from local, Fill in the MerchantSalt parameter with other hash parameters blank if you must, it needs to be calculated from server side only. Here, hashString contains hash created from your server side.
  /// https://payumobile.gitbook.io/sdk-integration/android/payucheckoutpro/hash-details
  /// hash name payment_related_details_for_mobile_sdk
  String hash1;

  /// hash name vas_for_mobile_sdk
  String hash2;

  /// hash name eligibleBinsForEMI
  String hash3;

  /// hash name vas_for_mobile_sdk
  String hash4;

  /// hash name delete_user_card
  String hash5;

  /// hash name payment
  String hash6;

  Payu({
    @required this.amount,
    @required this.productInfo,
    @required this.merchantKey,
    this.merchantSalt,
    this.isProduction = true,
    this.phone,
    @required this.transactionId,
    @required this.firstName,
    @required this.email,
    @required this.surl,
    @required this.furl,
    this.userCredential,
    this.udf1 = "udf1",
    this.udf2 = "udf1",
    this.udf3 = "udf1",
    this.udf4 = "udf1",
    this.udf5 = "udf1",
    this.hash1,
    this.hash2,
    this.hash3,
    this.hash4,
    this.hash5,
    this.hash6,
  });

  /// Map 转实体类
  Payu.fromJson(Map<String, dynamic> json) {
    this.amount = json['amount'];
    this.productInfo = json['productInfo'];
    this.merchantKey = json['merchantKey'];
    this.merchantSalt = json['merchantSalt'];
    this.isProduction = json['isProduction'];
    this.phone = json['phone'];
    this.transactionId = json['transactionId'];
    this.firstName = json['firstName'];
    this.email = json['email'];
    this.surl = json['surl'];
    this.furl = json['furl'];
    this.userCredential = json['userCredential'];

    this.udf1 = json['udf1'];
    this.udf2 = json['udf2'];
    this.udf3 = json['udf3'];
    this.udf4 = json['udf4'];
    this.udf5 = json['udf5'];
    this.hash1 = json['hash1'];
    this.hash2 = json['hash2'];
    this.hash3 = json['hash3'];
    this.hash4 = json['hash4'];
    this.hash5 = json['hash5'];
    this.hash6 = json['hash6'];
  }

  /// 实体类转 Map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['productInfo'] = this.productInfo;
    data['merchantKey'] = this.merchantKey;
    data['merchantSalt'] = this.merchantSalt;
    data['isProduction'] = this.isProduction;
    data['phone'] = this.phone;
    data['transactionId'] = this.transactionId;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    data['surl'] = this.surl;
    data['furl'] = this.furl;
    data['userCredential'] = this.userCredential;

    data['udf1'] = this.udf1;
    data['udf2'] = this.udf2;
    data['udf3'] = this.udf3;
    data['udf4'] = this.udf4;
    data['udf5'] = this.udf5;
    data['hash1'] = this.hash1;
    data['hash2'] = this.hash2;
    data['hash3'] = this.hash3;
    data['hash4'] = this.hash4;
    data['hash5'] = this.hash5;
    data['hash6'] = this.hash6;

    return data;
  }
}
