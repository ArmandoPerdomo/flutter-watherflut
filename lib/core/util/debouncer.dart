import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer{
  Timer _timer;

  void run(VoidCallback cb){
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), cb);

  }
}