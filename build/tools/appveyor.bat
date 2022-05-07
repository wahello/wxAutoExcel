md %build_dir% 
cd %build_dir%

echo CMAKE_BUILD_TYPE:STRING=%configuration% > CMakeCache.txt
echo wxWidgets_CONFIGURATION:STRING=mswu >> CMakeCache.txt
echo wxWidgets_LIB_DIR:PATH=%wxWidgets_LIBRARIES% >> CMakeCache.txt
echo wxWidgets_ROOT_DIR:PATH=%wxWidgets_ROOT_DIR% >> CMakeCache.txt
echo WX_LIB_DIR:INTERNAL=%wxWidgets_LIBRARIES% >> CMakeCache.txt
echo WX_ROOT_DIR:INTERNAL=%wxWidgets_ROOT_DIR% >> CMakeCache.txt
echo wxAutoExcel_BUILD_SHARED:BOOL=ON >> CMakeCache.txt 
echo wxAutoExcel_BUILD_LINK_WX_SHARED:BOOL=ON >> CMakeCache.txt

goto %toolset%

:msbuild
cmake -Wno-dev -G "Visual Studio 14 2015 Win64" %project_dir%
msbuild "ALL_BUILD.vcxproj" /consoleloggerparameters:Verbosity=minimal /target:Build  /p:Configuration=%configuration% /p:Platform=%platform% /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
goto :eof

:gcc810_x64
set path=C:\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\bin;C:\Program Files (x86)\CMake\bin
cmake -Wno-dev -G "MinGW Makefiles" %project_dir%
mingw32-make -j2 -f makefile
goto :eof

:eof