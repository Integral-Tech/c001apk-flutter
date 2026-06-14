# c001apk-flutter APK 构建脚本 (PowerShell版本)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  c001apk-flutter APK 构建脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Flutter是否安装
try {
    $flutterVersion = flutter --version
    Write-Host "[信息] Flutter已安装" -ForegroundColor Green
} catch {
    Write-Host "[错误] 未找到Flutter命令,请确保Flutter已正确安装并添加到PATH" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "[1/5] 检查Flutter环境..." -ForegroundColor Yellow
flutter doctor
if ($LASTEXITCODE -ne 0) {
    Write-Host "[警告] Flutter环境检查发现问题,请查看上面的输出" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[2/5] 清理旧的构建文件..." -ForegroundColor Yellow
flutter clean
if ($LASTEXITCODE -ne 0) {
    Write-Host "[错误] 清理失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "[3/5] 获取依赖包..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "[错误] 依赖获取失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "[4/5] 分析代码..." -ForegroundColor Yellow
flutter analyze
if ($LASTEXITCODE -ne 0) {
    Write-Host "[警告] 代码分析发现问题,但将继续构建" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[5/5] 构建正式版APK..." -ForegroundColor Yellow
Write-Host "注意: 使用调试签名进行构建" -ForegroundColor Cyan
Write-Host "如需正式签名,请配置正式的key.properties和keystore文件" -ForegroundColor Cyan
Write-Host ""

flutter build apk --release

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  构建成功!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    $apkPath = "build\app\outputs\flutter-apk\app-release.apk"
    Write-Host "APK文件位置: $apkPath" -ForegroundColor Green
    Write-Host ""
    
    # 打开APK所在文件夹
    if (Test-Path $apkPath) {
        explorer.exe (Split-Path $apkPath)
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  构建失败!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "请查看上面的错误信息" -ForegroundColor Red
}

Write-Host ""
Read-Host "按回车键退出"
