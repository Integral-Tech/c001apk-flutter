# 构建前检查清单

## ✅ 环境检查

在开始构建之前,请确认以下项目:

### Flutter环境
- [ ] Flutter SDK已安装 (版本 >= 3.22.0)
- [ ] Flutter已添加到PATH环境变量
- [ ] 运行 `flutter --version` 可以正常显示版本信息

### Android环境
- [ ] Android Studio已安装
- [ ] Android SDK已安装
- [ ] ANDROID_HOME环境变量已配置
- [ ] 已接受Android SDK许可证

### Java环境
- [ ] JDK 17已安装
- [ ] JAVA_HOME环境变量已配置

### 设备/模拟器 (用于测试)
- [ ] Android设备已连接并启用开发者模式
- [ ] 或Android模拟器已启动

## ✅ 项目检查

### 代码完整性
- [ ] 所有源文件已正确保存
- [ ] 没有编译错误
- [ ] pubspec.yaml中的依赖配置正确

### 依赖包
- [ ] 运行过 `flutter pub get`
- [ ] 所有依赖包已成功下载
- [ ] 没有依赖冲突

### 国际化支持
- [ ] flutter_localizations依赖已添加
- [ ] app_strings.dart文件存在
- [ ] main.dart中已配置locale和localizationsDelegates

### 资源配置
- [ ] 应用图标已准备 (assets/icon/)
- [ ] 启动画面资源已准备
- [ ] AndroidManifest.xml配置正确

## ✅ 签名配置

### 调试版 (测试用)
- [ ] android/key.properties文件已创建
- [ ] 调试密钥库路径配置正确
- [ ] 密码等敏感信息已填写

### 正式版 (发布用) - 可选
- [ ] 已生成正式密钥库文件(.jks或.keystore)
- [ ] key.properties中配置了正式签名信息
- [ ] 密钥文件已安全备份
- [ ] 密钥文件未提交到Git仓库

## ✅ 构建配置

### Android配置
- [ ] android/app/build.gradle配置正确
- [ ] namespace和applicationId设置正确
- [ ] compileSdk、minSdk、targetSdk版本合适
- [ ] signingConfigs配置完整

### 版本信息
- [ ] pubspec.yaml中的version已设置
- [ ] version格式正确 (例如: 1.0.0+1)

### 权限配置
- [ ] AndroidManifest.xml中的权限声明正确
- [ ] Deep link配置正确(如需要)
- [ ] 网络安全性配置(如需要)

## ✅ 构建前清理

- [ ] 运行过 `flutter clean`
- [ ] 旧的build目录已清理
- [ ] .dart_tool目录已清理(如有必要)

## ✅ 测试检查

### 功能测试
- [ ] 应用可以正常启动
- [ ] 主要功能可以正常使用
- [ ] 国际化文本显示正确
- [ ] 网络连接正常
- [ ] 图片加载正常
- [ ] 登录功能正常(如适用)

### UI测试
- [ ] 界面布局正常
- [ ] 文字显示完整无截断
- [ ] 按钮可以点击
- [ ] 列表可以滚动
- [ ] 深色模式适配(如支持)

### 性能测试
- [ ] 应用启动时间合理
- [ ] 页面切换流畅
- [ ] 无明显卡顿
- [ ] 内存占用合理

## ✅ 构建执行

### 执行构建命令
```bash
flutter build apk --release
```

或使用脚本:
- [ ] Windows: 双击 build_apk.bat
- [ ] PowerShell: 运行 build_apk.ps1

### 监控构建过程
- [ ] 观察控制台输出
- [ ] 注意是否有警告或错误
- [ ] 记录构建时间

## ✅ 构建后验证

### APK文件检查
- [ ] APK文件已生成在正确位置
- [ ] APK文件大小合理(通常20-50MB)
- [ ] APK文件名符合预期

### APK验证
```bash
# 查看APK信息
aapt dump badging build/app/outputs/flutter-apk/app-release.apk

# 验证签名(如已签名)
apksigner verify build/app/outputs/flutter-apk/app-release.apk
```

### 安装测试
- [ ] APK可以成功安装到设备
- [ ] 安装后应用图标显示正常
- [ ] 应用可以正常启动
- [ ] 主要功能测试通过

### 多设备测试 (推荐)
- [ ] 在不同品牌设备上测试
- [ ] 在不同Android版本上测试
- [ ] 在不同屏幕尺寸上测试

## ✅ 发布前准备 (正式发布时)

### 安全检查
- [ ] 使用正式签名(非调试签名)
- [ ] 密钥已安全备份
- [ ] 移除调试代码和日志
- [ ] 禁用开发者选项

### 性能优化
- [ ] 启用代码混淆(ProGuard/R8)
- [ ] 移除未使用的资源
- [ ] 图片已压缩优化
- [ ] 网络请求已优化

### 文档准备
- [ ] 更新CHANGELOG.md
- [ ] 准备应用说明
- [ ] 准备截图和宣传图
- [ ] 更新README.md

### 备份
- [ ] 备份密钥文件
- [ ] 备份构建产物
- [ ] 标记Git版本tag

## 📊 检查完成度

完成以上所有检查项后,你的APK就可以发布了!

---

**提示**: 
- 建议将常用检查项制成模板,每次构建时对照检查
- 对于持续集成(CI),可以将这些检查自动化
- 定期更新检查清单以适应项目变化
