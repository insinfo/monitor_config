import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'constants.dart';

// typedef struct _DISPLAY_DEVICEW {
//   DWORD cb;
//   WCHAR DeviceName[32];
//   WCHAR DeviceString[128];
//   DWORD StateFlags;
//   WCHAR DeviceID[128];
//   WCHAR DeviceKey[128];
// } DISPLAY_DEVICEW, *PDISPLAY_DEVICEW, *LPDISPLAY_DEVICEW;

/// DISPLAY_DEVICEW, *PDISPLAY_DEVICEW, *LPDISPLAY_DEVICEW;
class DISPLAY_DEVICEW extends Struct {
  /// DWORD cb;
  /// Size, in bytes, of the DISPLAY_DEVICE structure. This must be initialized prior to calling EnumDisplayDevices.
  @Uint32()
  external int cb;

  /// allocate and initalize Pointer<DISPLAY_DEVICEW>
  static Pointer<DISPLAY_DEVICEW> create() {
    late Pointer<DISPLAY_DEVICEW> _devicePointer;
    var size = sizeOf<DISPLAY_DEVICEW>();
    _devicePointer = calloc.allocate<DISPLAY_DEVICEW>(size);
    _devicePointer.ref.cb = size;
    return _devicePointer;
  }

  /// WCHAR DeviceName[32];
  @Array(32)
  external Array<Uint16> DeviceNameP;

  String get DeviceName {
    final charCodes = <int>[];
    for (var i = 0; i < 32; i++) {
      if (DeviceNameP[i] == 0x00) break;
      charCodes.add(DeviceNameP[i]);
    }
    return String.fromCharCodes(charCodes);
  }

  set DeviceName(String value) {
    final stringToStore = value.padRight(32, '\x00');
    for (var i = 0; i < 32; i++) {
      DeviceNameP[i] = stringToStore.codeUnitAt(i);
    }    
  }

  /// WCHAR DeviceString[128];
  @Array(128)
  external Array<Uint16> _DeviceString;

  /// get Graphic Card name
  String get DeviceString {
    final charCodes = <int>[];
    for (var i = 0; i < 32; i++) {
      if (_DeviceString[i] == 0x00) break;
      charCodes.add(_DeviceString[i]);
    }
    return String.fromCharCodes(charCodes);
  }

  set DeviceString(String value) {
    final stringToStore = value.padRight(32, '\x00');
    for (var i = 0; i < 32; i++) {
      _DeviceString[i] = stringToStore.codeUnitAt(i);
    }
  }

  /// DWORD StateFlags
  /// Device state flags. It can be any reasonable combination of the following.

  @Uint32()
  external int StateFlags;

  String get getStateMsg {
   
    switch (StateFlags) {
      case DISPLAY_DEVICE_ATTACHED_TO_DESKTOP:
        return 'DISPLAY_DEVICE_ATTACHED_TO_DESKTOP';
      case DISPLAY_DEVICE_MULTI_DRIVER:
        return 'DISPLAY_DEVICE_MULTI_DRIVER';
      case DISPLAY_DEVICE_PRIMARY_DEVICE:
        return 'DISPLAY_DEVICE_PRIMARY_DEVICE';
      case DISPLAY_DEVICE_MIRRORING_DRIVER:
        return 'DISPLAY_DEVICE_MIRRORING_DRIVER';
      case DISPLAY_DEVICE_VGA_COMPATIBLE:
        return 'DISPLAY_DEVICE_VGA_COMPATIBLE';
      case DISPLAY_DEVICE_REMOVABLE:
        return 'DISPLAY_DEVICE_REMOVABLE';
      case DISPLAY_DEVICE_MODESPRUNED:
        return 'DISPLAY_DEVICE_MODESPRUNED';
      case DISPLAY_DEVICE_REMOTE:
        return 'DISPLAY_DEVICE_REMOTE';
      case DISPLAY_DEVICE_DISCONNECT:
        return 'DISPLAY_DEVICE_DISCONNECT';
      case DISPLAY_DEVICE_TS_COMPATIBLE:
        return 'DISPLAY_DEVICE_TS_COMPATIBLE';
      case DISPLAY_DEVICE_UNSAFE_MODES_ON:
        return 'DISPLAY_DEVICE_UNSAFE_MODES_ON';
      default:
        return 'unknown StateFlags $StateFlags';
    }
  }

  /// WCHAR DeviceID[128];
  @Array(128)
  external Array<Uint16> _DeviceID;

  String get DeviceID {
    final charCodes = <int>[];
    for (var i = 0; i < 32; i++) {
      if (_DeviceID[i] == 0x00) break;
      charCodes.add(_DeviceID[i]);
    }
    return String.fromCharCodes(charCodes);
  }

  set DeviceID(String value) {
    final stringToStore = value.padRight(32, '\x00');
    for (var i = 0; i < 32; i++) {
      _DeviceID[i] = stringToStore.codeUnitAt(i);
    }
  }

  /// WCHAR DeviceKey[128];
  @Array(128)
  external Array<Uint16> _DeviceKey;

  String get DeviceKey {
    final charCodes = <int>[];
    for (var i = 0; i < 32; i++) {
      if (_DeviceKey[i] == 0x00) break;
      charCodes.add(_DeviceKey[i]);
    }
    return String.fromCharCodes(charCodes);
  }

  set DeviceKey(String value) {
    final stringToStore = value.padRight(32, '\x00');
    for (var i = 0; i < 32; i++) {
      _DeviceKey[i] = stringToStore.codeUnitAt(i);
    }
  }
}
