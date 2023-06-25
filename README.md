# Worldline PG Flutter Plugin

The Worldline PG (Payment Gateway) Flutter Plugin provides seamless integration between your Flutter application and the native code provided by the Worldline Payment Gateway. This plugin allows you to easily incorporate Worldline's powerful payment processing capabilities into your Flutter app, enabling secure and reliable payment transactions.

## Features

- Connect your Flutter app with the Worldline Payment Gateway native code.
- Perform various payment-related operations such as generating hash for requests, parsing responses, and more.
- Handle payment response data and retrieve transaction details with ease.
- Smooth integration with Flutter applications, ensuring a seamless user experience.
- Simplify payment-related tasks by leveraging the capabilities of the Worldline Payment Gateway.

## Getting Started

To use the Worldline PG Flutter Plugin, you need to follow these steps:

### 1. Install and Configure Worldline Payment Gateway SDK

#### Android

Before integrating the plugin, make sure you have placed the jar file provided in Worldline SDK in this plugin's android folder.

 copy the jar file to the following path

 $HOME/.pub-cache/hosted/pub.dev (on macOS and Linux)

 %LOCALAPPDATA%\Pub\Cache (on Windows)

 ```android/src/assets/merchant-kit-sdk.jar```

### 2. Installation

Add the following line to your pubspec.yaml file:

```yaml
dependencies:
  worldline_pg: ^0.0.1
```

### 3. Import the Plugin

In your Dart code, import the Worldline PG Flutter Plugin:

```dart
import 'package:worldline_pg/worldline_pg.dart';
```

### 4. Usage

Utilize the plugin's APIs to initiate payment transactions, retrieve payment status, and handle responses. Below is an example of initiating a payment transaction:

```dart
Future<void> _getRequestHash() async {
    String MID = 'your_merchant_id';
    String _orderID = 'your_order_id';
    String requestHash;
    try {
        requestHash = await _worldlinePg.getTrnRequestHash(
            orderId: _orderID,
            /// for ₹1.00 use 100
            trnAmt: '100',
            trnCurrency: 'INR',
            meTransReqType: 'S',
            responseUrl: 'https://www.google.com',
            trnRemarks: 'College Fee',
        );
    } on PlatformException {
        requestHash = 'Failed to get request hash.';
    }

    var _bytes = Uint8List.fromList(
        utf8.encode("merchantRequest=$requestHash&MID=$MID"));
}
```

Refer to the plugin's example code for a comprehensive list of available APIs and their usage.

## Issues and Contributions

This package is still in beta and is subject to change. If you encounter any issues with the Worldline PG Flutter Plugin or would like to contribute to its development, please visit the [GitHub repository](https://github.com/devalfaz/worldline_pg). Your feedback and contributions are highly appreciated.

## License

This plugin is released under the [BSD-3-Clause](LICENSE). Please review the LICENSE file for more details.