// ignore_for_file: camel_case_extensions, unnecessary_this

import 'dart:ffi';

import 'package:ffi/ffi.dart';

/// The POINTL structure defines the x- and y-coordinates of a point.
///
/// {@category Struct}
class POINTL extends Struct {
  @Int32()
  external int x;

  @Int32()
  external int y;
}

// typedef struct _devicemodeW {
//   WCHAR dmDeviceName[CCHDEVICENAME];
//   WORD  dmSpecVersion;
//   WORD  dmDriverVersion;
//   WORD  dmSize;
//   WORD  dmDriverExtra;
//   DWORD dmFields;
//   union {
//     struct {
//       short dmOrientation;
//       short dmPaperSize;
//       short dmPaperLength;
//       short dmPaperWidth;
//       short dmScale;
//       short dmCopies;
//       short dmDefaultSource;
//       short dmPrintQuality;
//     } DUMMYSTRUCTNAME;
//     POINTL dmPosition;
//     struct {
//       POINTL dmPosition;
//       DWORD  dmDisplayOrientation;
//       DWORD  dmDisplayFixedOutput;
//     } DUMMYSTRUCTNAME2;
//   } DUMMYUNIONNAME;
//   short dmColor;
//   short dmDuplex;
//   short dmYResolution;
//   short dmTTOption;
//   short dmCollate;
//   WCHAR dmFormName[CCHFORMNAME];
//   WORD  dmLogPixels;
//   DWORD dmBitsPerPel;
//   DWORD dmPelsWidth;
//   DWORD dmPelsHeight;
//   union {
//     DWORD dmDisplayFlags;
//     DWORD dmNup;
//   } DUMMYUNIONNAME2;
//   DWORD dmDisplayFrequency;
//   DWORD dmICMMethod;
//   DWORD dmICMIntent;
//   DWORD dmMediaType;
//   DWORD dmDitherType;
//   DWORD dmReserved1;
//   DWORD dmReserved2;
//   DWORD dmPanningWidth;
//   DWORD dmPanningHeight;
// } DEVMODEW, *PDEVMODEW, *NPDEVMODEW, *LPDEVMODEW;
/// The DEVMODE data structure contains information about the initialization
/// and environment of a printer or a display device.
///
/// {@category Struct}
class DEVMODE extends Struct {
  
  /// allocate and initalize Pointer<DEVMODE>
  static Pointer<DEVMODE> create() {
    late Pointer<DEVMODE> _devicePointer;
    var size = sizeOf<DEVMODE>();
    _devicePointer = calloc.allocate<DEVMODE>(size);
    _devicePointer.ref.dmSize = size;
    return _devicePointer;
  }

  ///  WCHAR dmDeviceName[CCHDEVICENAME];
  @Array(32)
  external Array<Uint16> _dmDeviceName;

  String get dmDeviceName {
    final charCodes = <int>[];
    for (var i = 0; i < 32; i++) {
      if (_dmDeviceName[i] == 0x00) break;
      charCodes.add(_dmDeviceName[i]);
    }
    return String.fromCharCodes(charCodes);
  }

  set dmDeviceName(String value) {
    final stringToStore = value.padRight(32, '\x00');
    for (var i = 0; i < 32; i++) {
      _dmDeviceName[i] = stringToStore.codeUnitAt(i);
    }
  }

  @Uint16()
  external int dmSpecVersion;

  @Uint16()
  external int dmDriverVersion;

  @Uint16()
  external int dmSize;

  ///  WORD  dmDriverExtra;
  @Uint16()
  external int dmDriverExtra;

  ///   DWORD dmFields;
  @Uint32()
  external int dmFields;

  external _DEVMODEW__Anonymous1_e__Union Anonymous1;

  @Uint16()
  external int dmColor;

  @Uint16()
  external int dmDuplex;

  @Int16()
  external int dmYResolution;

  @Uint16()
  external int dmTTOption;

  @Uint16()
  external int dmCollate;

  @Array(32)
  external Array<Uint16> _dmFormName;

  String get dmFormName {
    final charCodes = <int>[];
    for (var i = 0; i < 32; i++) {
      if (_dmFormName[i] == 0x00) break;
      charCodes.add(_dmFormName[i]);
    }
    return String.fromCharCodes(charCodes);
  }

  set dmFormName(String value) {
    final stringToStore = value.padRight(32, '\x00');
    for (var i = 0; i < 32; i++) {
      _dmFormName[i] = stringToStore.codeUnitAt(i);
    }
  }

  @Uint16()
  external int dmLogPixels;

  @Uint32()
  external int dmBitsPerPel;

  @Uint32()
  external int dmPelsWidth;

  @Uint32()
  external int dmPelsHeight;

  external _DEVMODEW__Anonymous2_e__Union Anonymous2;

  @Uint32()
  external int dmDisplayFrequency;

  @Uint32()
  external int dmICMMethod;

  @Uint32()
  external int dmICMIntent;

  @Uint32()
  external int dmMediaType;

  @Uint32()
  external int dmDitherType;

  @Uint32()
  external int dmReserved1;

  @Uint32()
  external int dmReserved2;

  @Uint32()
  external int dmPanningWidth;

  @Uint32()
  external int dmPanningHeight;
}

// extension DevmodeEx on DEVMODE {
//   /// init Pointer  calloc
//   static Pointer<DEVMODE> initializeP() {
//     var dmSize = sizeOf<DEVMODE>();
//     var modePointer = calloc.allocate<DEVMODE>(dmSize);
//     return modePointer;
//   }

//   static DEVMODE initialize() {
//     var dmSize = sizeOf<DEVMODE>();
//     var modePointer = initializeP();
//     var mode = modePointer.ref;
//     //Initialize
//     mode.dmDeviceName = 'teste';
//     mode.dmFormName = 'teste';
//     mode.dmSize = dmSize;
//     return mode;
//   }
// }

/// {@category Struct}
class _DEVMODEW__Anonymous1_e__Union extends Union {
  external _DEVMODEW__Anonymous1_e__Union__Anonymous1_e__Struct Anonymous1;

  external _DEVMODEW__Anonymous1_e__Union__Anonymous2_e__Struct Anonymous2;
}

/// {@category Struct}
class _DEVMODEW__Anonymous1_e__Union__Anonymous1_e__Struct extends Struct {
  @Int16()
  external int dmOrientation;

  @Int16()
  external int dmPaperSize;

  @Int16()
  external int dmPaperLength;

  @Int16()
  external int dmPaperWidth;

  @Int16()
  external int dmScale;

  @Int16()
  external int dmCopies;

  @Int16()
  external int dmDefaultSource;

  @Int16()
  external int dmPrintQuality;
}

extension DEVMODEW__Anonymous1_e__Union_Extension on DEVMODE {
  int get dmOrientation => this.Anonymous1.Anonymous1.dmOrientation;
  set dmOrientation(int value) =>
      this.Anonymous1.Anonymous1.dmOrientation = value;

  int get dmPaperSize => this.Anonymous1.Anonymous1.dmPaperSize;
  set dmPaperSize(int value) => this.Anonymous1.Anonymous1.dmPaperSize = value;

  int get dmPaperLength => this.Anonymous1.Anonymous1.dmPaperLength;
  set dmPaperLength(int value) =>
      this.Anonymous1.Anonymous1.dmPaperLength = value;

  int get dmPaperWidth => this.Anonymous1.Anonymous1.dmPaperWidth;
  set dmPaperWidth(int value) =>
      this.Anonymous1.Anonymous1.dmPaperWidth = value;

  int get dmScale => this.Anonymous1.Anonymous1.dmScale;
  set dmScale(int value) => this.Anonymous1.Anonymous1.dmScale = value;

  int get dmCopies => this.Anonymous1.Anonymous1.dmCopies;
  set dmCopies(int value) => this.Anonymous1.Anonymous1.dmCopies = value;

  int get dmDefaultSource => this.Anonymous1.Anonymous1.dmDefaultSource;
  set dmDefaultSource(int value) =>
      this.Anonymous1.Anonymous1.dmDefaultSource = value;

  int get dmPrintQuality => this.Anonymous1.Anonymous1.dmPrintQuality;
  set dmPrintQuality(int value) =>
      this.Anonymous1.Anonymous1.dmPrintQuality = value;
}

/// {@category Struct}
class _DEVMODEW__Anonymous1_e__Union__Anonymous2_e__Struct extends Struct {
  external POINTL dmPosition;

  @Uint32()
  external int dmDisplayOrientation;

  @Uint32()
  external int dmDisplayFixedOutput;
}

extension DEVMODEW__Anonymous1_e__Union_Extension_1 on DEVMODE {
  POINTL get dmPosition => this.Anonymous1.Anonymous2.dmPosition;
  set dmPosition(POINTL value) => this.Anonymous1.Anonymous2.dmPosition = value;

  int get dmDisplayOrientation =>
      this.Anonymous1.Anonymous2.dmDisplayOrientation;
  set dmDisplayOrientation(int value) =>
      this.Anonymous1.Anonymous2.dmDisplayOrientation = value;

  int get dmDisplayFixedOutput =>
      this.Anonymous1.Anonymous2.dmDisplayFixedOutput;
  set dmDisplayFixedOutput(int value) =>
      this.Anonymous1.Anonymous2.dmDisplayFixedOutput = value;
}

extension DEVMODEW_Extension on DEVMODE {
  _DEVMODEW__Anonymous1_e__Union__Anonymous1_e__Struct get Anonymous1 =>
      this.Anonymous1.Anonymous1;
  set Anonymous1(_DEVMODEW__Anonymous1_e__Union__Anonymous1_e__Struct value) =>
      this.Anonymous1.Anonymous1 = value;

  _DEVMODEW__Anonymous1_e__Union__Anonymous2_e__Struct get Anonymous2 =>
      this.Anonymous1.Anonymous2;
  set Anonymous2(_DEVMODEW__Anonymous1_e__Union__Anonymous2_e__Struct value) =>
      this.Anonymous1.Anonymous2 = value;
}

/// {@category Struct}
class _DEVMODEW__Anonymous2_e__Union extends Union {
  @Uint32()
  external int dmDisplayFlags;

  @Uint32()
  external int dmNup;
}

extension DEVMODEW_Extension_1 on DEVMODE {
  int get dmDisplayFlags => this.Anonymous2.dmDisplayFlags;
  set dmDisplayFlags(int value) => this.Anonymous2.dmDisplayFlags = value;

  int get dmNup => this.Anonymous2.dmNup;
  set dmNup(int value) => this.Anonymous2.dmNup = value;
}
