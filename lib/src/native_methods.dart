// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:monitor_config/monitor_config.dart';
import 'devmode_struct.dart';
import 'display_device_struct.dart';

final _user32 = DynamicLibrary.open('user32.dll');

/// The ChangeDisplaySettings function changes the settings of the default
/// display device to the specified graphics mode.
///
/// ```c
/// LONG ChangeDisplaySettingsW(
///   DEVMODEW *lpDevMode,
///   DWORD    dwFlags
/// );
/// ```
/// {@category user32}
int ChangeDisplaySettings(Pointer<DEVMODE> lpDevMode, int dwFlags) =>
    _ChangeDisplaySettings(lpDevMode, dwFlags);

final _ChangeDisplaySettings = _user32.lookupFunction<
    Int32 Function(Pointer<DEVMODE> lpDevMode, Uint32 dwFlags),
    int Function(
        Pointer<DEVMODE> lpDevMode, int dwFlags)>('ChangeDisplaySettingsW');

/// The ChangeDisplaySettingsEx function changes the settings of the
/// specified display device to the specified graphics mode.
///
/// ```c
/// LONG ChangeDisplaySettingsExW(
///   LPCWSTR  lpszDeviceName,
///   DEVMODEW *lpDevMode,
///   HWND     hwnd,
///   DWORD    dwflags,
///   LPVOID   lParam
/// );
/// ```
/// {@category user32}
int ChangeDisplaySettingsEx(Pointer<Utf16> lpszDeviceName,
        Pointer<DEVMODE> lpDevMode, int hwnd, int dwflags, Pointer lParam) =>
    _ChangeDisplaySettingsEx(lpszDeviceName, lpDevMode, hwnd, dwflags, lParam);

final _ChangeDisplaySettingsEx = _user32.lookupFunction<
    Int32 Function(Pointer<Utf16> lpszDeviceName, Pointer<DEVMODE> lpDevMode,
        IntPtr hwnd, Uint32 dwflags, Pointer lParam),
    int Function(Pointer<Utf16> lpszDeviceName, Pointer<DEVMODE> lpDevMode,
        int hwnd, int dwflags, Pointer lParam)>('ChangeDisplaySettingsExW');

/// The EnumDisplaySettings function retrieves information
/// about one of the graphics modes for a display device.
/// To retrieve information for all the graphics
/// modes of a display device, make a series of calls to this function.
///
/// Example: if (0 != EnumDisplaySettings(NULL, ENUM_CURRENT_SETTINGS, &dm))
/// https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-enumdisplaysettingsw
int EnumDisplaySettings(Pointer<Utf16> lpszDeviceName, int iModeNum,
        Pointer<DEVMODE> lpDevMode) =>
    _EnumDisplaySettings(lpszDeviceName, iModeNum, lpDevMode);

final _EnumDisplaySettings = _user32.lookupFunction<
    Int32 Function(Pointer<Utf16> lpszDeviceName, Uint32 iModeNum,
        Pointer<DEVMODE> lpDevMode),
    int Function(Pointer<Utf16> lpszDeviceName, int iModeNum,
        Pointer<DEVMODE> lpDevMode)>('EnumDisplaySettingsW');

/// The EnumDisplayDevices function lets you obtain information about the display devices in the current session.
/// [lpDevice] A pointer to the device name. If NULL, function returns information for the display adapter(s) on the machine, based on iDevNum.
/// [iDevNum] An index value that specifies the display device of interest.
/// [lpDisplayDevice] out A pointer to a DISPLAY_DEVICE structure that receives information about the display device specified by iDevNum.
/// [dwFlags] Set this flag to EDD_GET_DEVICE_INTERFACE_NAME (0x00000001) to retrieve the device interface name for
/// GUID_DEVINTERFACE_MONITOR, which is registered by the operating system on a per monitor basis.
/// The value is placed in the DeviceID member of the DISPLAY_DEVICE structure returned in lpDisplayDevice.
/// The resulting device interface name can be used with SetupAPI functions and serves as a
/// link between GDI monitor devices and SetupAPI monitor devices.
int EnumDisplayDevices(Pointer<Utf16> lpDevice, int iDevNum,
        Pointer<DISPLAY_DEVICEW> lpDisplayDevice, int dwFlags) =>
    _EnumDisplayDevices(lpDevice, iDevNum, lpDisplayDevice, dwFlags);

final _EnumDisplayDevices = _user32.lookupFunction<
    Int32 Function(Pointer<Utf16> lpDevice, Uint32 iDevNum,
        Pointer<DISPLAY_DEVICEW> lpDisplayDevice, Uint32 dwFlags),
    int Function(
        Pointer<Utf16> lpDevice,
        int iDevNum,
        Pointer<DISPLAY_DEVICEW> lpDisplayDevice,
        int dwFlags)>('EnumDisplayDevicesW');


