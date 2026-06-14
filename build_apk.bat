@echo off
chcp 65001 >nul
echo ========================================
echo   c001apk-flutter APK Build Script
echo ========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter command not found. Please ensure Flutter is properly installed and added to PATH
    pause
    exit /b 1
)

echo [1/5] Checking Flutter environment...
flutter doctor
if %errorlevel% neq 0 (
    echo [WARNING] Flutter environment check found issues, please check the output above
    pause
)

echo.
echo [2/5] Cleaning old build files...
flutter clean
if %errorlevel% neq 0 (
    echo [ERROR] Clean failed
    pause
    exit /b 1
)

echo.
echo [3/5] Getting dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Dependency fetch failed
    pause
    exit /b 1
)

echo.
echo [4/5] Analyzing code...
flutter analyze
if %errorlevel% neq 0 (
    echo [WARNING] Code analysis found issues, but will continue building
)

echo.
echo [5/5] Building release APK...
echo Note: Using debug signing for build
echo For formal signing, please configure proper key.properties and keystore files
echo.

flutter build apk --release

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo   Build Successful!
    echo ========================================
    echo.
    echo APK file location: build\app\outputs\flutter-apk\app-release.apk
    echo.
    explorer build\app\outputs\flutter-apk
) else (
    echo.
    echo ========================================
    echo   Build Failed!
    echo ========================================
    echo Please check the error messages above
)

pause
