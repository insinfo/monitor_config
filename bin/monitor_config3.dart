import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:monitor_config/src/constants.dart';
import 'package:monitor_config/src/display_manager.dart';
import 'package:monitor_config/src/utils.dart';

import 'package:win32/win32.dart';
import 'package:win32/winrt.dart';

var hWndButton = 0;
var hWndComboBox = 0;
const IDC_BUTTON1 = 101;
const IDC_COMBO1 = 105;
String? displaySelected;

int mainWindowProc(int hWnd, int uMsg, int wParam, int lParam) {
  //var hInstance = GetWindow(hWnd, GWL_HINSTANCE);
  switch (uMsg) {
    case WM_CREATE:
      //create Button
      hWndButton = CreateWindow(
          TEXT('Button'),
          TEXT('Rotacionar'),
          BS_PUSHBUTTON | WS_CHILD | WS_VISIBLE,
          50,
          50,
          100,
          25,
          hWnd,
          IDC_BUTTON1,
          g_hInstance,
          nullptr);

      hWndComboBox = CreateWindowEx(
          WS_EX_STATICEDGE,
          TEXT('COMBOBOX'),
          TEXT('MyCombo1'),
          WS_CHILD | WS_VISIBLE | WS_BORDER | CBS_DROPDOWN,
          10,
          10,
          200,
          200,
          hWnd,
          IDC_COMBO1,
          g_hInstance,
          nullptr);
      var displays = DisplayManager.listDisplays();
      displaySelected = displays.isNotEmpty ? displays.first : null;
      addItemsToComboBox(hWndComboBox, displays);
      //UpdateWindow(hWndComboBox);

      return 0;
    //on resize
    case WM_SIZE:
      UpdateWindow(hWndButton);
      UpdateWindow(hWndComboBox);
      // var width = LOWORD(lParam);
      // var height = HIWORD(lParam);
      // final rect = calloc<RECT>();
      // final rc = rect.ref;
      // GetClientRect(hBtn, rect);
      // var x = (width - (rc.right - rc.left)) / 2 as int;
      // var y = (height - (rc.bottom - rc.top)) / 2 as int;
      // MoveWindow(hBtn, x, y, rc.right - rc.left, rc.bottom - rc.top, 1);

      return 0;
    case WM_COMMAND:
      // close button click
      //if (LOWORD(wParam) == IDCLOSE) {}
      switch (HIWORD(wParam)) {
        case CBN_SELCHANGE:
          //print('CBN_SELCHANGE');
          var index = SendMessage(hWndComboBox, CB_GETCURSEL, 0, 0);
          if (index == CB_ERR) {
            print('CBN_SELCHANGE Handle error');
            return 0;
          }
          var len = SendMessage(hWndComboBox, CB_GETLBTEXTLEN, index, 0);
          if (len == CB_ERR) {
            print('CBN_SELCHANGE Handle error');
            return 0;
          }
          var optionSelectedP = calloc.allocate<Utf16>(len + 1);
          SendMessage(
              hWndComboBox, CB_GETLBTEXT, index, optionSelectedP.address);
          displaySelected = optionSelectedP.toDartString();
          print(displaySelected);
          return 0;
        case BN_CLICKED:
          switch (LOWORD(wParam)) {
            case IDC_BUTTON1:
              print('btn clicked');
              DisplayManager.rotateScreen(true, displayName: displaySelected);
              return 0;
          }
          return 0;
      }
      return 0;
    case WM_DESTROY:
      PostQuitMessage(0);
      return 0;

    case WM_PAINT:
      // final ps = calloc<PAINTSTRUCT>();
      // final hdc = BeginPaint(hWnd, ps);
      // final rect = calloc<RECT>();
      // final msg = TEXT('Hello, Dart!');

      // GetClientRect(hWnd, rect);
      // DrawText(hdc, msg, -1, rect, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
      // EndPaint(hWnd, ps);

      // free(ps);
      // free(rect);
      // free(msg);

      return 0;
  }
  return DefWindowProc(hWnd, uMsg, wParam, lParam);
}

// An optional approach to launching a GUI app that lets you use a more
// traditional WinMain entry point, rather than having to manually retrieve the
// hInstance and nShowCmd parameters.
void main() {
 // final hInstance = GetModuleHandle(nullptr);
  //ShowWindow(GetConsoleWindow(), SW_HIDE);
 //ShowWindow(hInstance, SW_HIDE);
  initApp(winMain);
}

// Instance handle
int g_hInstance = 0;

void winMain(int hInstance, List<String> args, int nShowCmd) {
  // Register the window class.
  g_hInstance = hInstance;
  final className = TEXT('Monitor config');
  final wc = calloc<WNDCLASS>()
    ..ref.style = CS_HREDRAW | CS_VREDRAW
    ..ref.lpfnWndProc = Pointer.fromFunction<WindowProc>(mainWindowProc, 0)
    ..ref.hInstance = hInstance
    ..ref.lpszClassName = className
    ..ref.hCursor = LoadCursor(NULL, IDC_ARROW)
    ..ref.hbrBackground = GetStockObject(LTGRAY_BRUSH);
  RegisterClass(wc);

  var idBtn = calloc.allocate<Int64>(sizeOf<Int64>());
  idBtn.value = 25;

  // Create the window.
  final windowCaption = TEXT('Monitor config');
  final hWnd = CreateWindowEx(
      0, // Optional window styles.
      className, // Window class
      windowCaption, // Window caption
      WS_OVERLAPPEDWINDOW, // Window style

      // Size and position
      CW_USEDEFAULT,
      CW_USEDEFAULT,
      640,
      480,
      //CW_USEDEFAULT,
      //CW_USEDEFAULT,
      NULL, // Parent window
      NULL, // Menu
      g_hInstance, // Instance handle
      nullptr // Additional application data
      );
  free(windowCaption);
  free(className);

  if (hWnd == 0) {
    final error = GetLastError();
    throw WindowsException(HRESULT_FROM_WIN32(error));
  }

  ShowWindow(hWnd, nShowCmd);
  UpdateWindow(hWnd);



  // Run the message loop.
  final msg = calloc<MSG>();
  while (GetMessage(msg, NULL, 0, 0) != 0) {
    TranslateMessage(msg);
    DispatchMessage(msg);
  }

  free(msg);
}
