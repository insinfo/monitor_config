# A simple command-line application.
## Windows display rotate with dart and ffi

dart compile exe .\bin\monitor_config2.dart -o .\bin\displayrotate2.exe
dart compile exe .\bin\monitor_config.dart -o .\bin\displayrotate1.exe

dart compile exe .\bin\monitor_config.dart -o .\bin\displayrotate3.exe

run displayrotate2.exe to rotate secondary display

run displayrotate.exe to rotate principal display

# execute this for remove console window
editbin.exe /subsystem:windows displayrotate3.exe

##### https://stackoverflow.com/questions/2435816/how-do-i-poke-the-flag-in-a-win32-pe-that-controls-console-window-display/2435907#2435907



