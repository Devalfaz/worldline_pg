// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:worldline_pg/worldline_pg.dart';

import 'package:http/http.dart' as http;

const String ENC_KEY = 'abcdefghiklgmno01234567';
const String FORM_ACTION_URL = "https://ipg.in.worldline.com/doMEPayRequest";
const String GET_TRANS_STATUS =
    "https://ipg.in.worldline.com/getTransactionStatus";
const String MID = 'WL000000000000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaymentStatus(),
    );
  }
}

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({super.key});

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  final _worldlinePg = WorldlinePg(
    enckey: ENC_KEY,
    mid: MID,
  );
  String _paymentStatus = 'Payment not initiated';

  _loadPaymentStatus(String orderId) async {
    var trnResParams =
        await _getPaymentStatus(orderId: orderId, url: GET_TRANS_STATUS);
    var url = Uri.parse(GET_TRANS_STATUS);
    var encryptedResponse = await http.post(
      url,
      body: trnResParams,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ).then((value) => value.body);
    log('Encrypted Response: $encryptedResponse');

    var decryptedResponse = await _worldlinePg.getParsedTrnResMsg(
      response: encryptedResponse,
    );
    log('Decrypted Response: ${decryptedResponse.toJson()}');

    setState(() {
      _paymentStatus = decryptedResponse.statusDesc;
    });
  }

  Future<String> _getPaymentStatus({
    required String orderId,
    required String url,
  }) async {
    String paymentStatus;
    try {
      paymentStatus = await _worldlinePg.getTrnResParams(
        orderId: orderId,
        url: url,
      );
    } on PlatformException {
      paymentStatus = 'Failed to get payment status.';
    }

    log('Payment Status: $paymentStatus');
    return paymentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _paymentStatus,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => const PaymentPage(),
                  ),
                )
                    .then((value) {
                  _loadPaymentStatus(value);
                });
              },
              child: const Text('Initiate Payment'),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Uint8List _bytes = Uint8List(0);
  final GlobalKey _webViewKey = GlobalKey();
  final _orderID = '${DateTime.now().millisecondsSinceEpoch}';
  bool _isLoading = true;
  final _worldlinePg = WorldlinePg.instance;

  @override
  void initState() {
    super.initState();
    _getRequestHash();
  }

  Future<void> _getRequestHash() async {
    String requestHash;
    try {
      requestHash = await _worldlinePg.getTrnRequestHash(
        orderId: _orderID,
        trnAmt: '100',
        trnCurrency: 'INR',
        meTransReqType: 'S',
        responseUrl: 'https://www.google.com',
        trnRemarks: 'College Fee',
      );
    } on PlatformException {
      requestHash = 'Failed to get request hash.';
    }

    _bytes = Uint8List.fromList(
        utf8.encode("merchantRequest=$requestHash&MID=$MID"));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
          context,
          _orderID,
        );
        return false;
      },
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : InAppWebView(
                key: _webViewKey,
                initialUrlRequest: URLRequest(
                  url: Uri.parse(FORM_ACTION_URL),
                  method: 'POST',
                  body: _bytes,
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                  },
                ),
                onReceivedServerTrustAuthRequest:
                    (controller, challenge) async {
                  //Do some checks here to decide if CANCELS or PROCEEDS
                  return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED);
                },
              ),
      ),
    );
  }
}
