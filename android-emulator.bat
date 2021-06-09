:: Command Line Tools: https://developer.android.com/studio#cmdline-tools
:: Android API reference: https://source.android.com/setup/start/build-numbers#platform-code-names-versions-api-levels-and-ndk-releases
:: Download JDK from: https://www.oracle.com/java/technologies/javase-jdk16-downloads.html

@echo off

SET API=28
SET AVD_NAME=Android
SET BIN_INTERFACE=x86

SET LATEST_DIR=cmdline-tools\latest
SET IMAGE=system-images;android-%API%;google_apis;%BIN_INTERFACE%
SET ANDROID_SDK_ROOT=%~dp0
SET ANDROID_HOME=%ANDROID_SDK_ROOT%
SET EMULATOR_URL=https://dl.google.com/android/repository/emulator-windows_x64-7395805.zip

(mkdir %LATEST_DIR%
MOVE /Y cmdline-tools\* %LATEST_DIR%
MOVE /Y cmdline-tools\bin %LATEST_DIR%
MOVE /Y cmdline-tools\lib %LATEST_DIR%) >NUL 2>&1

PUSHD %LATEST_DIR%\bin
CALL:PatchSDKFile sdkmanager.bat sdklib
CALL:PatchSDKFile avdmanager.bat sdkmanager

:Install
ECHO yes|sdkmanager --install "emulator" 2>NUL
IF %ERRORLEVEL% EQU 1 CALL:DownloadEmulator
ECHO yes|sdkmanager --install "%IMAGE%"
ECHO yes|sdkmanager "platform-tools" "platforms;android-%API%"
ECHO no|avdmanager -s create avd --name "%AVD_NAME%" --package "%IMAGE%" --abi "%BIN_INTERFACE%"
ECHO hw.keyboard=yes >> "%USERPROFILE%\.android\avd\%AVD_NAME%.avd\config.ini"
POPD

PUSHD emulator
emulator @%AVD_NAME% -no-boot-anim -netdelay none -no-snapshot -skin 400x800 >NUL 2>&1
POPD
EXIT /b

:PatchSDKFile
SET PATCH_FILE=%1.PATCH
IF EXIST %PATCH_FILE% EXIT /b

COPY /Y NUL %PATCH_FILE% >NUL 2>&1
FOR /F "delims=" %%a IN ('type %1') do (
    echo.%%a | findstr /C:"set DEFAULT_JVM_OPTS">nul && (
        echo/set DEFAULT_JVM_OPTS=-Dcom.android.%2.toolsdir="%%~dp0\..">> %PATCH_FILE%
     ) || (
        echo/%%a>> %PATCH_FILE%
     )
)
COPY /Y %PATCH_FILE% %1 >NUL 2>&1
EXIT /b

:DownloadEmulator
POPD
IF EXIST emulator PUSHD %LATEST_DIR%\bin & EXIT /b
ECHO Downloading emulator...
SET OUTFILE=emulator.zip
POWERSHELL -Command (new-object System.Net.WebClient).DownloadFile('%EMULATOR_URL%','%OUTFILE%')
unzip "%OUTFILE%" -d . >NUL
COPY /Y fake-package.xml "emulator\package.xml" >NUL
DEL %OUTFILE%
PUSHD %LATEST_DIR%\bin