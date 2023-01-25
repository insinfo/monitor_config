import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:monitor_config/monitor_config.dart';
import 'package:monitor_config/src/display_device_struct.dart';
import 'package:win32/win32.dart' as win32;

/// rotate primary display
void main(List<String> arguments) {
  DisplayManager.rotateScreen(true);
}
