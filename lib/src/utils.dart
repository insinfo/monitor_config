import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'constants.dart';

Pointer<Pointer<Utf16>> strListToPointer16(List<String> strings) {
  var utf16PointerList = strings.map((str) => str.toNativeUtf16()).toList();
  final pointerPointer =
      malloc.allocate<Pointer<Utf16>>(utf16PointerList.length);
  strings.asMap().forEach((index, utf) {
    pointerPointer[index] = utf16PointerList[index];
  });
  return pointerPointer;
}

void addItemsToComboBox(int hWndComboBox, List<String> strings) {
  //LPARAM => LONG_PTR > IntPtr >  Abi.windowsX64: Uint64()
  // Add string to combobox.
  for (var i = 0; i < strings.length; ++i) {
    var str = strings[i].toNativeUtf16();
    SendMessage(hWndComboBox, CB_ADDSTRING, 0, str.address);
  }

  SendMessage(hWndComboBox, CB_SETCURSEL, 0, NULL);
}
