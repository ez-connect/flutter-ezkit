import 'dart:async';

/// Throttle an action uses Timer
/// Example:
/// final debouncer = Debouncer(Duration(milliseconds: 500));
/// debouncer.run(() => print('Hello world'));
class Debouncer {
  final Duration duration;

  Timer _timer;

  Debouncer({this.duration});

  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(this.duration, callback);
  }
}
