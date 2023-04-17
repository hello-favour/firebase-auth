import 'package:flutter/cupertino.dart';

void authPrint(dynamic value) {
  debugPrint(value.toString());
}

int timeNow() {
  return DateTime.now().microsecondsSinceEpoch;
}
