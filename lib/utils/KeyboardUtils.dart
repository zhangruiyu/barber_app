import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardUtils {
  static void hide() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
