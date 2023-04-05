import 'package:mocktail/mocktail.dart';

abstract class CallbackHandler<T> {
  void call(T param);
}

class MockCallback<T> extends Mock implements CallbackHandler<T> {}
