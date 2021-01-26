# Flutter payu SDK 

# author

zhaolong Email:<zhaoyuen123@126.com>

# Integration Steps

## Step 1: Add Dependency


```yaml
  flutter_payu: ^0.0.1
```

<br/>

## Step 2: Add permissions (Android)

The Cashfree PG SDK requires that you add the INTERNET permission in your `Android Manifest` file.

```xml
<manifest ...>
    <uses-permission android:name="android.permission.INTERNET" />
<application ...>
```
## Step 3: Add plist value (iOS)

Opt-in to the embedded views preview by adding a boolean property to the app's Info.plist file with the key io.flutter.embedded_views_preview and the value YES. This is required by the flutter_webview plugin.

```plist
    <key>io.flutter.embedded_views_preview</key>
    <true/>
```

## Step 4: Register merchantKey,merchantSalt
[here.](https://onboarding.payu.in/app/account)

## Step 5: Initiate Payment

- App passes the order info and the token to the SDK
- Customer is shown the payment screen where he completes the payment
- Once the payment is complete SDK verifies the payment
- App receives the response from SDK and handles it appropriately


## How to integrate

For both the modes (normal and [seamless](https://payumobile.gitbook.io/sdk-integration/android/android-sdk-offering)) you need to invoke the <b>doPayment()</b> method. However, there are a few extra parameters you need to pass incase of seamless mode.


### doPayment

```dart
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

```

## example

```dart
    final FlutterPayu _flutterPayu = FlutterPayu();
    _flutterPayu.on(FlutterPayu.EVENT_PAYMENT_SUCCESS, _handlePayuPaymentSuccess);
    _flutterPayu.on(FlutterPayu.EVENT_PAYMENT_ERROR, _handlePayuPaymentError);
    _flutterPayu.on(FlutterPayu.EVENT_PAYMENT_FAILURE, _handlePayuPaymentFailure);
    _flutterPayu.on(FlutterPayu.EVENT_PAYMENT_CANCEL, _handlePayuPaymentCancel);
    
    void _handlePayuPaymentSuccess(PayuSuccess response) async {
        print("Payu payment success payuResponse:" +response.payuResponse.toString());
        print("Payu payment success merchantResponse:" +response.merchantResponse.toString());
    }

    void _handlePayuPaymentFailure(PayuFailure response) async {
        print("Payu payment failure payuResponse:" +response.payuResponse.toString());
        print("Payu payment failure merchantResponse:" +response.merchantResponse.toString());
    }

    void _handlePayuPaymentError(PayuError payuError) async {
        print("Payu error:${payuError.message}");
    }

    void _handlePayuPaymentCancel(PayuError payuError) {
        print("Payu cancel:${payuError.message}");
    }
``` 

# Payu Parameters
[here.](https://payumobile.gitbook.io/sdk-integration/android/payucheckoutpro/build-the-payment-params)

| Parameter                                 | Required | Description                                      |
|-------------------------------------|-----------|----------------------------------------------------|
| <code>merchantSalt</code>            | No      | Merchant salt received from PayU Can be filled in, if not null will calculate the hash locally      |


### NOTE

There can be scenarios where the SDK is not able to verify the payment within a short period of time. The status of such orders will be <code><b>PENDING</b></code>
