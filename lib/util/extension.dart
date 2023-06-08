import 'package:flutter/widgets.dart';

extension ObjExtension<T> on T {
  T2 call<T2>(T2 Function(T v) act) => act(this);
}

extension NumExtension on num {
  Widget get spaceH => SizedBox(height: toDouble());

  Widget get spaceW => SizedBox(width: toDouble());
  Duration get ms => Duration(milliseconds: toInt());
}

extension StringExtension on String {
  Color toColor() {
    String s = this;
    if (s.startsWith("0x")) s = s.substring(2);
    if (s.startsWith("#")) s = s.substring(1);
    while (s.length < 8) {
      s = "F" + s;
    }
    var v = int.tryParse(s, radix: 16) ?? 0;
    return Color(v);
  }

  int toInt({int or = 0}) => int.tryParse(this) ?? or;

  double toDouble({double or = 0.0}) => double.tryParse(this) ?? or;

  bool inLength(int min, int max) {
    if (length < min) return false;
    if (length > max) return false;
    return true;
  }

  String blur({bool? end, String blur = "..."}) {
    var v = this;
    if (v.length < 4) return v;
    if (end == true) return v.substring(0, 4) + blur;
    return v.substring(0, 4) + blur + v.substring(v.length - 4);
  }
}
