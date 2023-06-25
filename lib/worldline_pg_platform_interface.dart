import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:worldline_pg/models/trans_res.dart';

import 'worldline_pg_method_channel.dart';

abstract class WorldlinePgPlatform extends PlatformInterface {
  /// Constructs a WorldlinePgPlatform.
  WorldlinePgPlatform() : super(token: _token);

  static final Object _token = Object();

  static WorldlinePgPlatform _instance = MethodChannelWorldlinePg();

  /// The default instance of [WorldlinePgPlatform] to use.
  ///
  /// Defaults to [MethodChannelWorldlinePg].
  static WorldlinePgPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WorldlinePgPlatform] when
  /// they register themselves.
  static set instance(WorldlinePgPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns a [TransResMsg] object from the response string.
  Future<TransResMsg> getParsedTrnResMsg({
    required String response,
    required String enckey,
  });

  /// Returns the parameter for Transaction status for the given order id.
  Future<String> getTrnResParams({
    required String orderId,
    required String mid,
    required String enckey,
    required String url,
    String? pgMeTrnRefNo,
  });

  /// Returns the parameter for Transaction request for the given order id.
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
  });
}
