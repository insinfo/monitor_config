import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:monitor_config/monitor_config.dart';
import 'package:win32/win32.dart' as win32;

import 'display_device_struct.dart';

/// enum
class DisplayChangeResult {
  const DisplayChangeResult(this.value);
  final int value;

  /// <summary>
  /// Windows XP: The settings change was unsuccessful because system is DualView capable.
  /// </summary>
  static DisplayChangeResult BadDualView = DisplayChangeResult(-6);

  /// <summary>
  /// An invalid parameter was passed in. This can include an invalid flag or combination of flags.
  /// </summary>
  static DisplayChangeResult BadParam = DisplayChangeResult(-5);

  /// <summary>
  /// An invalid set of flags was passed in.
  /// </summary>
  static DisplayChangeResult BadFlags = DisplayChangeResult(-4);

  /// <summary>
  /// Windows NT/2000/XP: Unable to write settings to the registry.
  /// </summary>
  static DisplayChangeResult NotUpdated = DisplayChangeResult(-3);

  /// <summary>
  /// The graphics mode is not supported.
  /// </summary>
  static DisplayChangeResult BadMode = DisplayChangeResult(-2);

  /// <summary>
  /// The display driver failed the specified graphics mode.
  /// </summary>
  static DisplayChangeResult Failed = DisplayChangeResult(-1);

  /// <summary>
  /// The settings change was successful.
  /// </summary>
  static DisplayChangeResult Successful = DisplayChangeResult(0);

  /// <summary>
  /// The computer must be restarted in order for the graphics mode to work.
  /// </summary>
  static DisplayChangeResult Restart = DisplayChangeResult(1);

  @override
  String toString() {
    var msg = '';
    if (value == DisplayChangeResult.BadDualView.value) {
      msg = 'InvalidOperation_Disp_Change_BadDualView';
    } else if (value == DisplayChangeResult.BadParam.value) {
      msg = 'InvalidOperation_Disp_Change_BadParam';
    } else if (value == DisplayChangeResult.BadFlags.value) {
      msg = 'InvalidOperation_Disp_Change_BadFlags';
    } else if (value == DisplayChangeResult.NotUpdated.value) {
      msg = 'InvalidOperation_Disp_Change_NotUpdated';
    } else if (value == DisplayChangeResult.BadMode.value) {
      msg = 'InvalidOperation_Disp_Change_BadMode';
    } else if (value == DisplayChangeResult.Failed.value) {
      msg = 'InvalidOperation_Disp_Change_Failed';
    } else if (value == DisplayChangeResult.Restart.value) {
      msg = 'InvalidOperation_Disp_Change_Restart';
    } else if (value == DisplayChangeResult.Restart.value) {
      msg = 'InvalidOperation_Disp_Change_Restart';
    }

    return msg;
  }
}

class DisplayManager {
  static DisplaySettings getCurrentSettings({String? displayName}) {
    return createDisplaySettingsObject(
        -1, getDeviceModeP(displayName: displayName));
  }

  // static DEVMODE getDeviceMode() {
  //   var dmSize = sizeOf<DEVMODE>();
  //   var modePointer = calloc.allocate<DEVMODE>(dmSize);
  //   var mode = modePointer.ref;
  //   //Initialize
  //   mode.dmDeviceName = 'teste';
  //   mode.dmFormName = 'teste';
  //   mode.dmSize = dmSize;

  //   if (EnumDisplaySettings(nullptr, ENUM_CURRENT_SETTINGS, modePointer) == 1) {
  //     return mode;
  //   } else {
  //     throw Exception(win32.GetLastError());
  //   }
  // }

  static Pointer<DEVMODE> getDeviceModeP({String? displayName}) {
    var dmSize = sizeOf<DEVMODE>();
    var modePointer = calloc.allocate<DEVMODE>(dmSize);
    var mode = modePointer.ref;
    //Initialize
    mode.dmDeviceName = '';
    mode.dmFormName = '';
    mode.dmSize = dmSize;

    if (EnumDisplaySettings(
            displayName == null ? nullptr : displayName.toNativeUtf16(),
            ENUM_CURRENT_SETTINGS,
            modePointer) ==
        1) {
      return modePointer;
    } else {
      throw Exception(win32.GetLastError());
    }
  }

  static Iterable<DisplaySettings> getModesEnumerator() sync* {
    var dmSize = sizeOf<DEVMODE>();
    var modePointer = calloc.allocate<DEVMODE>(dmSize);
    var mode = modePointer.ref;
    //Initialize
    mode.dmDeviceName = 'teste';
    mode.dmFormName = 'teste';
    mode.dmSize = dmSize;

    var idx = 0;

    while (EnumDisplaySettings(nullptr, idx, modePointer) == 1) {
      yield createDisplaySettingsObject(idx++, modePointer);
    }
  }

  static void setDisplaySettings(DisplaySettings set, {String? displayName}) {
    var modeP = getDeviceModeP(displayName: displayName);
    var mode = modeP.ref;
    mode.dmPelsWidth = set.width;
    mode.dmPelsHeight = set.height;
    mode.dmDisplayOrientation = set.orientation.value;
    mode.dmBitsPerPel = set.bitCount;
    mode.dmDisplayFrequency = set.frequency;
    var result;
    if (displayName != null) {
      var displayNameP = displayName.toNativeUtf16();
      result = ChangeDisplaySettingsEx(
          displayNameP, modeP, 0, CDS_RESET | CDS_UPDATEREGISTRY, nullptr);
    } else {
      result = ChangeDisplaySettings(modeP, 0);
    }
    print('setDisplaySettings $result');
    String? msg;
    if (result == DisplayChangeResult.BadDualView.value) {
      msg = 'InvalidOperation_Disp_Change_BadDualView';
    } else if (result == DisplayChangeResult.BadParam.value) {
      msg = 'InvalidOperation_Disp_Change_BadParam';
    } else if (result == DisplayChangeResult.BadFlags.value) {
      msg = 'InvalidOperation_Disp_Change_BadFlags';
    } else if (result == DisplayChangeResult.NotUpdated.value) {
      msg = 'InvalidOperation_Disp_Change_NotUpdated';
    } else if (result == DisplayChangeResult.BadMode.value) {
      msg = 'InvalidOperation_Disp_Change_BadMode';
    } else if (result == DisplayChangeResult.Failed.value) {
      msg = 'InvalidOperation_Disp_Change_Failed';
    } else if (result == DisplayChangeResult.Restart.value) {
      msg = 'InvalidOperation_Disp_Change_Restart';
    } else if (result == DisplayChangeResult.Restart.value) {
      msg = 'InvalidOperation_Disp_Change_Restart';
    }

    print('setDisplaySettings $msg');

    if (msg != null) throw Exception(msg);
  }

  static void rotateScreen(bool clockwise, {String? displayName}) {
    var set = DisplayManager.getCurrentSettings(displayName: displayName);

    var tmp = set.height;
    set.height = set.width;
    set.width = tmp;

    if (clockwise) {
      set.orientation.value++;
    } else {
      set.orientation.value--;
    }

    if (set.orientation.value < Orientation.Default.value) {
      set.orientation.value = Orientation.Clockwise270.value;
    } else if (set.orientation.value > Orientation.Clockwise270.value) {
      set.orientation.value = Orientation.Default.value;
    }

    setDisplaySettings(set, displayName: displayName);
  }

  static DisplaySettings createDisplaySettingsObject(
      int idx, Pointer<DEVMODE> modeP) {
    var mode = modeP.ref;
    var ds = DisplaySettings(
        index: idx,
        width: mode.dmPelsWidth,
        height: mode.dmPelsHeight,
        orientation: Orientation(mode.dmDisplayOrientation),
        bitCount: mode.dmBitsPerPel,
        frequency: mode.dmDisplayFrequency);
    calloc.free(modeP);
    return ds;
  }

  static List<String> listDisplays() {
    var result1 = 1;
    var displays = <String>[];
    for (var idx = 0; result1 != 0; idx++) {
      final devicePointer = DISPLAY_DEVICEW.create();
      //EDD_GET_DEVICE_INTERFACE_NAME
      result1 = EnumDisplayDevices(nullptr, idx, devicePointer, 0);
      final currentDeviceName = devicePointer.ref.DeviceName.toNativeUtf16();
      if (result1 == 0) {
        break;
      }
      var modePointer = DEVMODE.create();

      // Read the current settings
      var result2 = EnumDisplaySettings(
          currentDeviceName, ENUM_CURRENT_SETTINGS, modePointer);

      if (result2 == 1) {
        displays.add(devicePointer.ref.DeviceName);
      }
      calloc.free(modePointer);
      calloc.free(devicePointer);
    }
    return displays;
  }
}

class DisplaySettings {
  int index;
  int width;
  int height;
  Orientation orientation;
  int bitCount;
  int frequency;
  DisplaySettings({
    required this.index,
    required this.width,
    required this.height,
    required this.orientation,
    required this.bitCount,
    required this.frequency,
  });

  @override
  String toString() {
    return 'DisplaySettings(index: $index, width: $width, height: $height, orientation: $orientation, bitCount: $bitCount, frequency: ${frequency}hz)';
  }
}

class Orientation {
  static Orientation Default = Orientation(0);
  static Orientation Clockwise90 = Orientation(1);
  static Orientation Clockwise180 = Orientation(2);
  static Orientation Clockwise270 = Orientation(3);

  int value;
  Orientation(this.value);

  @override
  String toString() {
    switch (value) {
      case 0:
        return 'Default';
      case 1:
        return 'Clockwise90';
      case 2:
        return 'Clockwise180';
      case 3:
        return 'Clockwise270';
    }
    return 'unknow';
  }
}
