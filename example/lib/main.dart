import 'package:flutter/material.dart';
import 'package:flutter_payu/flutter_payu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterPayu _flutterPayu = FlutterPayu();

  @override
  void initState() {
    super.initState();

    // 初始化payu
    _flutterPayu.on(
        FlutterPayu.EVENT_PAYMENT_SUCCESS, _handlePayuPaymentSuccess);
    _flutterPayu.on(FlutterPayu.EVENT_PAYMENT_ERROR, _handlePayuPaymentError);
    _flutterPayu.on(
        FlutterPayu.EVENT_PAYMENT_FAILURE, _handlePayuPaymentFailure);
    _flutterPayu.on(FlutterPayu.EVENT_PAYMENT_CANCEL, _handlePayuPaymentCancel);
  }

  @override
  void dispose() {
    super.dispose();
    _flutterPayu.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example payu'),
        ),
        body: Center(
          child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: _doPayment,
                  child: Text("doPayment"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _doPayment() {
    String merchantKey = "gtKFFx";
    String email = "john@yopmail.com";
    String userCredential = merchantKey + ":" + email;
    Payu payu = new Payu(
      // test https://payumobile.gitbook.io/sdk-integration/test-merchant-list
      merchantKey: merchantKey,
      merchantSalt: "eCwWELxi",
      isProduction: false,
      amount: "1.0",
      email: email,
      firstName: "test",
      phone: "9876543210",
      surl: "https://payuresponse.firebaseapp.com/success",
      furl: "https://payuresponse.firebaseapp.com/failure",
      productInfo: "test",
      transactionId: "test-" + DateTime.now().millisecondsSinceEpoch.toString(),
      userCredential: userCredential,
    );
    _flutterPayu.doPayment(payu);
  }

  // 支付成功处理
  void _handlePayuPaymentSuccess(PayuSuccess response) async {
    print("Payu payment success payuResponse:" +response.payuResponse.toString());
    print("Payu payment success merchantResponse:" +response.merchantResponse.toString());
  }

  // 支付失败事件处理
  void _handlePayuPaymentFailure(PayuFailure response) async {
    print("Payu payment failure payuResponse:" +response.payuResponse.toString());
    print("Payu payment failure merchantResponse:" +response.merchantResponse.toString());
  }

  // 错误事件处理
  void _handlePayuPaymentError(PayuError payuError) async {
    print("Payu error:${payuError.message}");
  }

  void _handlePayuPaymentCancel(PayuError payuError) {
    print("Payu cancel:${payuError.message}");
  }
}
