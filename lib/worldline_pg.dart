export 'package:worldline_pg/models/trans_res.dart';

import 'models/trans_res.dart';
import 'worldline_pg_platform_interface.dart';

class WorldlinePg {
  // Create a singleton for the plugin class and add mid and enckey to it.
  static final WorldlinePg _instance = WorldlinePg._internal();
  factory WorldlinePg({required String mid, required String enckey}) {
    _instance.setMid(mid);
    _instance.setEnckey(enckey);
    return _instance;
  }
  WorldlinePg._internal();

  // Get the singleton.
  static WorldlinePg get instance => _instance;

  // Add mid and enckey to the singleton.
  late String _mid;
  late String _enckey;

  void setMid(String mid) {
    _mid = mid;
  }

  void setEnckey(String enckey) {
    _enckey = enckey;
  }

  String get mid => _mid;
  String get enckey => _enckey;

  WorldlinePgPlatform get _worldlinePgPlatform => WorldlinePgPlatform.instance;

  Future<TransResMsg> getParsedTrnResMsg({
    required String response,
  }) {
    return _worldlinePgPlatform.getParsedTrnResMsg(
      enckey: _enckey,
      response: response,
    );
  }

  Future<String> getTrnResParams({
    required String orderId,
    required String url,
    String? pgMeTrnRefNo,
  }) {
    return _worldlinePgPlatform.getTrnResParams(
      orderId: orderId,
      mid: mid,
      enckey: enckey,
      url: url,
      pgMeTrnRefNo: pgMeTrnRefNo,
    );
  }

  /// The amount of the transaction should be 100 if it is ₹1.00.
  Future<String> getTrnRequestHash({
    required String orderId,
    required String trnAmt,
    required String trnCurrency,
    required String meTransReqType,
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
  }) {
    return _worldlinePgPlatform.getTrnRequestHash(
      orderId: orderId,
      mid: mid,
      trnAmt: trnAmt,
      trnCurrency: trnCurrency,
      meTransReqType: meTransReqType,
      enckey: enckey,
      responseUrl: responseUrl,
      trnRemarks: trnRemarks,
      addField1: addField1,
      addField2: addField2,
      addField3: addField3,
      addField4: addField4,
      addField5: addField5,
      addField6: addField6,
      addField7: addField7,
      addField8: addField8,
      addField9: addField9,
      addField10: addField10,
    );
  }
}
