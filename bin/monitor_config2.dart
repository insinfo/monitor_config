import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:monitor_config/monitor_config.dart';
import 'package:monitor_config/src/display_device_struct.dart';
import 'package:win32/win32.dart' as win32;

/// rotate secondary display
void main(List<String> arguments) {
 
  var displays = 0;
  var result1 = 1;
  for (var idx = 0; result1 != 0; idx++) {
    var devicePointer = DISPLAY_DEVICEW.create();

    result1 = EnumDisplayDevices(
        nullptr, idx, devicePointer, 0); //EDD_GET_DEVICE_INTERFACE_NAME
    var currentDeviceName = devicePointer.ref.DeviceName.toNativeUtf16();
    //print('EnumDisplayDevices result: $result1');

    if (result1 == 0) {
      break;
    }
    var modePointer = DEVMODE.create();

    // Read the current settings
    var result2 = EnumDisplaySettings(
        currentDeviceName, ENUM_CURRENT_SETTINGS, modePointer);
    //print('EnumDisplaySettings result: $result2');

    if (result2 == 1) {
      //only secundary display
      if (devicePointer.ref.StateFlags != 5) {
        print('''StateFlags ${devicePointer.ref.StateFlags} ''');
        print('''${devicePointer.ref.DeviceName} 
          Width: ${modePointer.ref.dmPelsWidth} Height: ${modePointer.ref.dmPelsHeight} 
          Orientation ${modePointer.ref.dmDisplayOrientation} Frequency ${modePointer.ref.dmDisplayFrequency} bitCount ${modePointer.ref.dmBitsPerPel}
          ''');

        calloc.free(devicePointer);
        //---------------------- rotate ----------------------
        var set = DisplayManager.createDisplaySettingsObject(-1, modePointer);

        var tmp = set.height;
        set.height = set.width;
        set.width = tmp;
        set.orientation.value++;
        if (set.orientation.value < Orientation.Default.value) {
          set.orientation.value = Orientation.Clockwise270.value;
        } else if (set.orientation.value > Orientation.Clockwise270.value) {
          set.orientation.value = Orientation.Default.value;
        }
        modePointer.ref.dmPelsWidth = set.width;
        modePointer.ref.dmPelsHeight = set.height;
        modePointer.ref.dmDisplayOrientation = set.orientation.value;
        modePointer.ref.dmBitsPerPel = set.bitCount;
        modePointer.ref.dmDisplayFrequency = set.frequency;

        var result3 = ChangeDisplaySettingsEx(currentDeviceName, modePointer, 0,
            CDS_RESET | CDS_UPDATEREGISTRY, nullptr);
        print('ChangeDisplay  ${DisplayChangeResult(result3)} | $result3');
      }
      displays++;
    }
  }
}
