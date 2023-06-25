import 'package:flutter_test/flutter_test.dart';
import 'package:worldline_pg/worldline_pg.dart';
import 'package:worldline_pg/worldline_pg_platform_interface.dart';
import 'package:worldline_pg/worldline_pg_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWorldlinePgPlatform
    with MockPlatformInterfaceMixin
    implements WorldlinePgPlatform {
  @override
  Future<TransResMsg> getParsedTrnResMsg(
      {required String response, required String enckey}) {
    return Future.value(TransResMsg.fromJson({}));
  }

  @override
  Future<String> getTrnRequestHash(
      {required String orderId,
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
      String? addField10}) {
    return Future.value('42');
  }

  @override
  Future<String> getTrnResParams(
      {required String orderId,
      required String mid,
      required String enckey,
      required String url,
      String? pgMeTrnRefNo}) {
    return Future.value('42');
  }
}

void main() {
  final WorldlinePgPlatform initialPlatform = WorldlinePgPlatform.instance;

  test('$MethodChannelWorldlinePg is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWorldlinePg>());
  });

  test('getPlatformVersion', () async {
    WorldlinePg worldlinePgPlugin = WorldlinePg(enckey: "", mid: "");
    MockWorldlinePgPlatform fakePlatform = MockWorldlinePgPlatform();
    WorldlinePgPlatform.instance = fakePlatform;

    expect(await worldlinePgPlugin.getParsedTrnResMsg(response: ""), '42');
  });
}
