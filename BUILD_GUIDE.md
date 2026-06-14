# c001apk-flutter 构建指南

## 前置要求

### 1. 安装Flutter SDK
- 下载并安装Flutter SDK (版本 >= 3.22.0)
- 配置Flutter到系统PATH环境变量
- 运行 `flutter doctor` 检查环境

### 2. 安装Android Studio和Android SDK
- 安装Android Studio
- 安装Android SDK (建议使用最新稳定版)
- 配置ANDROID_HOME环境变量
- 接受Android SDK许可证: `flutter doctor --android-licenses`

### 3. 安装Java JDK
- 安装JDK 17 (推荐)
- 配置JAVA_HOME环境变量

## 快速构建

### 方法一: 使用批处理脚本 (推荐)

双击运行项目根目录下的:
- **build_apk.bat** (CMD版本)
- **build_apk.ps1** (PowerShell版本,需要管理员权限)

脚本会自动执行以下步骤:
1. 检查Flutter环境
2. 清理旧的构建文件
3. 获取依赖包
4. 分析代码
5. 构建正式版APK

### 方法二: 手动构建

在项目根目录打开终端,依次执行:

```bash
# 1. 清理旧文件
flutter clean

# 2. 获取依赖
flutter pub get

# 3. 分析代码(可选)
flutter analyze

# 4. 构建正式版APK
flutter build apk --release
```

## 签名配置

### 调试版签名 (用于测试)

项目已配置调试版签名,位于 `android/key.properties`:

```properties
storePassword=android
keyPassword=android
keyAlias=androiddebugkey
storeFile=../debug.keystore
```

**注意**: 调试签名仅用于测试,不要发布到应用商店!

### 正式版签名 (用于发布)

#### 1. 生成密钥库文件

```bash
keytool -genkey -v -keystore c001apk-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias c001apk
```

按照提示输入:
- 密钥库密码
- 姓名、组织单位、组织、城市、省份、国家代码等信息

#### 2. 配置key.properties

在 `android/` 目录下创建或编辑 `key.properties`:

```properties
storePassword=你的密钥库密码
keyPassword=你的密钥密码
keyAlias=c001apk
storeFile=c001apk-release.jks
```

**重要**: 
- 将生成的 `.jks` 文件放在 `android/` 目录下
- 不要将密钥文件提交到Git仓库 (已在.gitignore中排除)
- 妥善保管密码,丢失后无法恢复

#### 3. 构建签名APK

```bash
flutter build apk --release
```

APK文件位置: `build/app/outputs/flutter-apk/app-release.apk`

## 其他构建选项

### 构建Split APK (按ABI分离)

生成更小的APK文件,针对不同CPU架构:

```bash
flutter build apk --release --split-per-abi
```

输出文件:
- `app-armeabi-v7a-release.apk` (ARM 32位)
- `app-arm64-v8a-release.apk` (ARM 64位)
- `app-x86_64-release.apk` (x86 64位)

### 构建App Bundle (推荐用于Google Play)

```bash
flutter build appbundle --release
```

输出文件: `build/app/outputs/bundle/release/app-release.aab`

### 指定版本号

```bash
flutter build apk --release --build-name=1.0.0 --build-number=1
```

## 常见问题

### 1. Flutter命令未找到

**解决方案**: 
- 确保Flutter已正确安装
- 将Flutter的bin目录添加到PATH环境变量
- 重启终端或IDE

### 2. Android SDK未找到

**解决方案**:
```bash
flutter config --android-sdk /path/to/android/sdk
```

### 3. 依赖冲突

**解决方案**:
```bash
flutter clean
flutter pub upgrade
flutter pub get
```

### 4. 构建失败 - OutOfMemoryError

**解决方案**: 编辑 `android/gradle.properties`,增加内存:
```properties
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError
```

### 5. 签名配置错误

**错误信息**: "SigningConfig 'release' is missing required properties"

**解决方案**:
- 检查 `android/key.properties` 文件是否存在
- 确认所有必需的属性都已配置
- 确认密钥库文件路径正确

### 6. 国际化相关错误

如果构建时出现国际化相关错误:

```bash
# 确保flutter_localizations已正确添加
flutter pub get

# 清理并重新构建
flutter clean
flutter build apk --release
```

## 验证APK

### 检查APK信息

```bash
# 查看APK详细信息
aapt dump badging build/app/outputs/flutter-apk/app-release.apk

# 验证签名
apksigner verify build/app/outputs/flutter-apk/app-release.apk
```

### 在设备上测试

```bash
# 连接设备后安装APK
adb install build/app/outputs/flutter-apk/app-release.apk

# 如果有多个设备,指定设备ID
adb -s <device_id> install build/app/outputs/flutter-apk/app-release.apk
```

## CI/CD 自动化构建

### GitHub Actions示例

项目已包含 `.github/workflows/build.yml`,可以自动构建APK。

触发方式:
- Push到main分支
- 创建新的Tag
- 手动触发workflow

构建产物会作为Artifact上传,可以在Actions页面下载。

## 优化建议

### 1. 减小APK体积

- 启用ProGuard/R8代码压缩
- 移除未使用的资源
- 使用WebP格式图片
- 考虑使用Split APK

### 2. 提升构建速度

- 使用SSD硬盘
- 增加Gradle并行构建: `org.gradle.parallel=true`
- 启用Gradle守护进程
- 使用本地Maven镜像

### 3. 安全性

- 使用强密码保护密钥库
- 定期备份密钥文件
- 不要在代码中硬编码密码
- 使用环境变量或CI/CD secrets管理敏感信息

## 技术支持

如遇到其他问题:
1. 查看Flutter官方文档: https://flutter.dev/docs
2. 查看Android构建文档: https://developer.android.com/studio/build
3. 查看项目Issues: https://github.com/your-repo/issues

## 更新日志

- 2024-06-11: 添加中文国际化支持
- 2024-06-11: 创建自动化构建脚本
- 2024-06-11: 完善构建文档
