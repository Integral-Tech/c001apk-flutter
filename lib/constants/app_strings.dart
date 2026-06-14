import 'package:flutter/material.dart';

class AppStrings {
  static AppStrings of(BuildContext context) {
    return AppStrings(Localizations.localeOf(context).languageCode);
  }

  final String languageCode;

  AppStrings(this.languageCode);

  // 通用文本
  String get cancel => _getText('cancel');
  String get confirm => _getText('confirm');
  String get ok => _getText('ok');
  String get delete => _getText('delete');
  String get download => _getText('download');
  String get copy => _getText('copy');
  String get block => _getText('block');
  String get report => _getText('report');
  String get showReply => _getText('showReply');
  String get clickToLogin => _getText('clickToLogin');
  String get fontScale => _getText('fontScale');
  String get reset => _getText('reset');
  String get login => _getText('login');
  String get settings => _getText('settings');
  String get about => _getText('about');
  String get back => _getText('back');
  String get search => _getText('search');
  String get home => _getText('home');
  String get discover => _getText('discover');
  String get message => _getText('message');
  String get mine => _getText('mine');
  String get clearCache => _getText('clearCache');
  String get viewLicense => _getText('viewLicense');
  String get close => _getText('close');
  
  // 用户相关
  String active(String time) => _getText('active').replaceAll('{time}', time);
  String followedByCount(int count) => _getText('followedByCount').replaceAll('{count}', count.toString());
  String contentCount(int count) => _getText('contentCount').replaceAll('{count}', count.toString());
  String likedYour(String info) => _getText('likedYour').replaceAll('{info}', info);

  String _getText(String key) {
    if (languageCode == 'zh') {
      return _zhStrings[key] ?? key;
    }
    return _enStrings[key] ?? key;
  }

  static const Map<String, String> _zhStrings = {
    'cancel': '取消',
    'confirm': '确认',
    'ok': '确定',
    'delete': '删除',
    'download': '下载',
    'copy': '复制',
    'block': '屏蔽',
    'report': '举报',
    'showReply': '查看回复',
    'clickToLogin': '点击登录',
    'fontScale': '字体大小',
    'reset': '重置',
    'login': '登录',
    'settings': '设置',
    'about': '关于',
    'back': '返回',
    'search': '搜索',
    'home': '首页',
    'discover': '发现',
    'message': '消息',
    'mine': '我的',
    'clearCache': '清除缓存',
    'viewLicense': '查看许可证',
    'close': '关闭',
    'active': '{time}活跃',
    'followedByCount': '{count}人关注',
    'contentCount': '{count}个内容',
    'likedYour': '赞了你的{info}',
  };

  static const Map<String, String> _enStrings = {
    'cancel': 'Cancel',
    'confirm': 'Confirm',
    'ok': 'OK',
    'delete': 'Delete',
    'download': 'Download',
    'copy': 'Copy',
    'block': 'Block',
    'report': 'Report',
    'showReply': 'Show Reply',
    'clickToLogin': 'Click to Login',
    'fontScale': 'Font Scale',
    'reset': 'Reset',
    'login': 'Login',
    'settings': 'Settings',
    'about': 'About',
    'back': 'Back',
    'search': 'Search',
    'home': 'Home',
    'discover': 'Discover',
    'message': 'Message',
    'mine': 'Mine',
    'clearCache': 'Clear Cache',
    'viewLicense': 'View License',
    'close': 'Close',
    'active': 'Active {time}',
    'followedByCount': '{count} followers',
    'contentCount': '{count} items',
    'likedYour': 'Liked your {info}',
  };
}
