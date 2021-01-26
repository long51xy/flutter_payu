import 'dart:async';
import 'dart:convert';

import 'package:eventify/eventify.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payu/payu.dart';
import 'package:flutter_payu/payu_error.dart';
import 'package:flutter_payu/payu_failure.dart';
import 'package:flutter_payu/payu_success.dart';

class FlutterPayu {
  EventEmitter _eventEmitter;
  static const MethodChannel _channel = const MethodChannel('flutter_payu');

  static const EVENT_PAYMENT_SUCCESS = 'payment.success';
  static const EVENT_PAYMENT_ERROR = 'payment.error';
  static const EVENT_PAYMENT_FAILURE = 'payment.failure';
  static const EVENT_PAYMENT_CANCEL = 'payment.cancel';

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  FlutterPayu() {
    _eventEmitter = new EventEmitter();
  }

  void doPayment(Payu payu) async {
    var response = await _channel.invokeMethod('doPayment', payu.toJson());
    _handleResult(response);
  }

  void on(String event, Function handler) {
    EventCallback cb = (event, cont) {
      handler(event.eventData);
    };
    _eventEmitter.on(event, null, cb);
    _resync();
  }

  void _resync() async {
    var response = await _channel.invokeMethod('resync');
    if (response != null) {
      _handleResult(response);
    }
  }

  /// Handles checkout response from platform
  void _handleResult(Map<dynamic, dynamic> response) {
    String eventName;
    Map<dynamic, dynamic> data = response["data"];

    dynamic payload;

    switch (response['type']) {
      case 0:
        eventName = EVENT_PAYMENT_ERROR;
        payload = PayuError(message: data["message"]);
        break;
      case 1:
        eventName = EVENT_PAYMENT_CANCEL;
        payload = PayuError(message: "User cancelled");
        break;
      case 2:
        eventName = EVENT_PAYMENT_FAILURE;
        payload = PayuFailure(
          payuResponse: jsonDecode(data['payuResponse']),
          merchantResponse: jsonDecode(data['merchantResponse']),
        );
        break;
      case 3:
        eventName = EVENT_PAYMENT_SUCCESS;
        payload = PayuSuccess(
          payuResponse: jsonDecode(data['payuResponse']),
          merchantResponse: jsonDecode(data['merchantResponse']),
        );
        break;
      default:
        eventName = EVENT_PAYMENT_ERROR;
        payload = PayuError(message: 'An unknown error occurred.');
    }

    _eventEmitter.emit(eventName, null, payload);
  }

  /// Clears all event listeners
  void clear() {
    _eventEmitter.clear();
  }
}
