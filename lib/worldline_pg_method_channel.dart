import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:worldline_pg/models/trans_res.dart';

import 'worldline_pg_platform_interface.dart';

/// An implementation of [WorldlinePgPlatform] that uses method channels.
class MethodChannelWorldlinePg extends WorldlinePgPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('worldline_pg');

  @override
  Future<TransResMsg> getParsedTrnResMsg({
    required String response,
    required String enckey,
  }) async {
    final trnResMsg =
        await methodChannel.invokeMethod<String>('getDecryptedResponse', {
      'response': response,
      'enckey': enckey,
    });
    return TransResMsg.fromJson(jsonDecode(trnResMsg ?? '{}'));
  }

  @override
  Future<String> getTrnResParams({
    required String orderId,
    required String mid,
    required String enckey,
    required String url,
    String? pgMeTrnRefNo,
  }) async {
    final parameters =
        await methodChannel.invokeMethod<String>('getStatusHash', {
      'orderId': orderId,
      'mid': mid,
      'enckey': enckey,
      'url': url,
      'pgMeTrnRefNo': pgMeTrnRefNo,
    });
    return parameters ?? 'Some Error Occured';
  }

  @override
  Future<String> getTrnRequestHash({
    required String orderId,
    required String mid,
    required String trnAmt,
    required String trnCurrency,
    required String meTransReqType,
    required String enckey,
    required String responseUrl,
    required String trnRemarks,
    String? addField1,
    String? addField2,
    String? addField3,
    String? addField4,
    String? addField5,
    String? addField6,
    String? addField7,
    String? addField8,
    String? addField9,
    String? addField10,
  }) async {
    final requestHash =
        await methodChannel.invokeMethod<String>('getRequestHash', {
      'orderId': orderId,
      'mid': mid,
      'trnAmt': trnAmt,
      'trnCurrency': trnCurrency,
      'meTransReqType': meTransReqType,
      'enckey': enckey,
      'responseUrl': responseUrl,
      'trnRemarks': trnRemarks,
      'addField1': addField1,
      'addField2': addField2,
      'addField3': addField3,
      'addField4': addField4,
      'addField5': addField5,
      'addField6': addField6,
      'addField7': addField7,
      'addField8': addField8,
      'addField9': addField9,
      'addField10': addField10,
    });
    return requestHash ?? 'Some Error Occured';
  }
}
