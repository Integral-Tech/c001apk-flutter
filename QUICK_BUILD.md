# 快速构建APK指南

## 🚀 最简单的方法 (3步完成)

### Windows用户

1. **确保Flutter环境已安装**
   - 如果未安装,请参考 [BUILD_GUIDE.md](BUILD_GUIDE.md)

2. **双击运行构建脚本**
   ```
   build_apk.bat
   ```
   或 (PowerShell版本):
   ```powershell
   .\build_apk.ps1
   ```

3. **等待构建完成**
   - 脚本会自动打开APK所在文件夹
   - APK位置: `build\app\outputs\flutter-apk\app-release.apk`

### 手动构建 (命令行)

```bash
# 1. 进入项目目录
cd D:\Users\guanh\AndroidStudioProjects\c001apk-flutter

# 2. 清理并获取依赖
flutter clean
flutter pub get

# 3. 构建APK
flutter build apk --release

# 4. 查看生成的APK
explorer build\app\outputs\flutter-apk
```

## 📱 安装APK到设备

### 方法一: USB连接

```bash
adb install build\app\outputs\flutter-apk\app-release.apk
```

### 方法二: 直接传输

1. 将APK文件复制到手机
2. 在手机上打开文件管理器
3. 点击APK文件进行安装
4. 允许"未知来源应用"安装权限

## ⚙️ 常见问题速查

### ❌ Flutter命令找不到

```bash
# 检查Flutter是否安装
flutter --version

# 如果未安装,下载并配置Flutter
# https://flutter.dev/docs/get-started/install
```

### ❌ 依赖错误

```bash
flutter clean
flutter pub get
```

### ❌ 构建失败

```bash
# 查看详细错误信息
flutter build apk --release -v

# 检查Android环境
flutter doctor
```

### ❌ 签名错误

当前使用调试签名,仅用于测试。如需正式发布,请配置正式签名(见BUILD_GUIDE.md)。

## 📊 构建时间参考

- 首次构建: 5-10分钟 (需要下载依赖)
- 后续构建: 2-5分钟
- 清理后重建: 5-8分钟

## ✅ 验证构建成功

构建成功后会看到:
```
✓ Built build\app\outputs\flutter-apk\app-release.apk (XX.XMB)
```

APK文件大小通常在 20-50MB 之间。

## 🔧 高级选项

### 生成更小的APK

```bash
# 按CPU架构分离APK
flutter build apk --release --split-per-abi
```

### 指定版本号

```bash
flutter build apk --release --build-name=1.0.0 --build-number=1
```

### 构建App Bundle (Google Play)

```bash
flutter build appbundle --release
```

## 📝 下一步

- 详细文档: [BUILD_GUIDE.md](BUILD_GUIDE.md)
- 国际化说明: [INTERNATIONALIZATION.md](INTERNATIONALIZATION.md)
- 项目README: [README.md](README.md)

---

**提示**: 如果是首次构建,建议先运行 `flutter doctor` 检查环境配置。
