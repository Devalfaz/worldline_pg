import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:worldline_pg/worldline_pg_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWorldlinePg platform = MethodChannelWorldlinePg();
  const MethodChannel channel = MethodChannel('worldline_pg');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getParsedTrnResMsg(enckey: "", response: ""), '42');
  });
}
