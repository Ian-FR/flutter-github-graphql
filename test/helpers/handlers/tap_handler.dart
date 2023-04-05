import 'package:mocktail/mocktail.dart';

abstract class TapHandler {
  void onPressed();
  void onChange<T>(T? value);
}

class MockTapHandler extends Mock implements TapHandler {}
