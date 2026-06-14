# 国际化支持说明

## 概述

本项目已添加完整的中文国际化支持,同时保留英文作为备选语言。

## 实现内容

### 1. 依赖配置
- 在 `pubspec.yaml` 中添加了 `flutter_localizations` 依赖

### 2. 国际化资源文件
创建了 `lib/constants/app_strings.dart`,包含:
- 中英文双语翻译
- 支持动态参数替换(如用户数量、时间等)
- 易于扩展的翻译键值对结构

### 3. 主应用配置
在 `lib/main.dart` 中配置了:
- 默认语言: 简体中文 (zh-CN)
- 支持的语言列表: 中文、英文
- Flutter本地化代理

### 4. 已国际化的文本
以下组件的硬编码文本已替换为国际化字符串:

#### 卡片组件
- `app_info_card.dart`: 下载按钮
- `app_update_card.dart`: 下载按钮
- `collection_card.dart`: 关注人数、内容数量
- `feed_card.dart`: 复制、屏蔽、举报、删除等操作菜单
- `feed_reply_card.dart`: 回复相关的操作菜单
- `like_card.dart`: 点赞通知文本
- `message_header_card.dart`: 登录提示
- `notification_card.dart`: 通知相关操作
- `user_info_card.dart`: 活跃时间显示

#### 对话框组件
- `dialog.dart`: 
  - SliderDialog (字体大小调整)
  - EditTextDialog (编辑文本)
  - ClearDialog (清除缓存)

## 使用方法

### 在代码中使用国际化文本

```dart
import '../constants/app_strings.dart';

// 在Widget中使用
Text(AppStrings.of(context).download)

// 带参数的文本
Text(AppStrings.of(context).followedByCount(100))
Text(AppStrings.of(context).active('昨天'))
```

### 添加新的翻译

1. 在 `app_strings.dart` 中添加新的getter方法
2. 在中英文Map中添加对应的翻译
3. 在代码中使用 `AppStrings.of(context).yourKey` 调用

示例:
```dart
// 添加getter
String get myNewText => _getText('myNewText');

// 在Map中添加翻译
static const Map<String, String> _zhStrings = {
  'myNewText': '我的新文本',
  // ...
};

static const Map<String, String> _enStrings = {
  'myNewText': 'My New Text',
  // ...
};
```

## 切换语言

目前默认使用中文,如需支持用户手动切换语言,可以:

1. 在设置中添加语言选择选项
2. 将选择的语言保存到本地存储
3. 在 `main.dart` 中读取用户选择的语言并设置locale

示例代码:
```dart
locale: Locale(GStorage.getLanguageCode(), ''),
```

## 待国际化的文本

以下位置的文本尚未完全国际化,后续可以继续完善:
- 其他页面中的标题和提示文本
- 错误消息和提示信息
- 设置页面的选项文本
- 其他硬编码的中英文文本

## 技术细节

- 使用Flutter官方的 `flutter_localizations` 包
- 通过 `Localizations.localeOf(context)` 获取当前语言
- 支持参数化文本,使用 `{param}` 占位符
- fallback机制:如果翻译不存在,返回英文版本
