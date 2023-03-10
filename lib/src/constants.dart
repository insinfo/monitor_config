



const FORMAT_MESSAGE_FROM_HMODULE = 0x800;

const FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x100;
const FORMAT_MESSAGE_IGNORE_INSERTS = 0x200;
const FORMAT_MESSAGE_FROM_SYSTEM = 0x1000;
const FORMAT_MESSAGE_FLAGS = FORMAT_MESSAGE_ALLOCATE_BUFFER |
    FORMAT_MESSAGE_IGNORE_INSERTS |
    FORMAT_MESSAGE_FROM_SYSTEM;

//https://github.com/tpn/winsdk-7/blob/master/v7.1A/Include/WinGDI.h
// StateFlags
// Device state flags. It can be any reasonable combination of the following.
const DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = 0x00000001;
const DISPLAY_DEVICE_MULTI_DRIVER = 0x00000002;
const DISPLAY_DEVICE_PRIMARY_DEVICE = 0x00000004;
const DISPLAY_DEVICE_MIRRORING_DRIVER = 0x00000008;
const DISPLAY_DEVICE_VGA_COMPATIBLE = 0x00000010;
//if (_WIN32_WINNT >= _WIN32_WINNT_WIN2K)
const DISPLAY_DEVICE_REMOVABLE = 0x00000020;
//#endif // (_WIN32_WINNT >= _WIN32_WINNT_WIN2K)
const DISPLAY_DEVICE_MODESPRUNED = 0x08000000;
//#if (_WIN32_WINNT >= _WIN32_WINNT_WIN2K)
const DISPLAY_DEVICE_REMOTE = 0x04000000;
const DISPLAY_DEVICE_DISCONNECT = 0x02000000;
//#endif
const DISPLAY_DEVICE_TS_COMPATIBLE = 0x00200000;
//#if (_WIN32_WINNT >= _WIN32_WINNT_LONGHORN)
const DISPLAY_DEVICE_UNSAFE_MODES_ON = 0x00080000;
//#endif

// Flags for EnumDisplayDevices
const EDD_GET_DEVICE_INTERFACE_NAME = 0x00000001;

// DEVMODE.dmDisplayOrientation
const int DMDO_DEFAULT = 0;
const int DMDO_90 = 1;
const int DMDO_180 = 2;
const int DMDO_270 = 3;

const int ENUM_CURRENT_SETTINGS = -1;
const int ENUM_REGISTRY_SETTINGS = -2;

const CDS_UPDATEREGISTRY = 1;
const CDS_TEST = 2;
const CDS_FULLSCREEN = 4;
const CDS_GLOBAL = 8;
const CDS_SET_PRIMARY = 16;
const CDS_RESET = 1073741824;
const CDS_SETRECT = 536870912;
const CDS_NORESET = 268435456;


//https://github.com/rofl0r/microwindows/blob/master/src/include/winctl.h
//pegar constants do arquivo python nesta URL abaixo
//https://github.com/pybee/toga-win32/blob/master/toga_win32/libs/constants.py
const BN_CLICKED = 0;
const CBS_DROPDOWN = 2;
const CBS_DROPDOWNLIST = 3;
const CB_ADDSTRING = 323;
const CB_SETCURSEL = 334;

const CBN_SELCHANGE = 1;
const CB_GETLBTEXTLEN = 329;
const CB_GETCURSEL = 327;
const CB_GETLBTEXT = 328;

var CB_ERR = (-1);