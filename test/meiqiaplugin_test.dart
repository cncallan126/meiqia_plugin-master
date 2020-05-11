import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meiqiaplugin/meiqiaplugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('meiqiaplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Meiqiaplugin.platformVersion, '42');
  });
}
