import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../components/dialog.dart';
import '../../components/settings/drop_down_menu_item.dart';
import '../../components/settings/edittext_item.dart';
import '../../components/settings/item_title.dart';
import '../../components/settings/switch_item.dart';
import '../../constants/constants.dart';
import '../../pages/blacklist/black_list_page.dart' show BlackListType;
import '../../utils/cache_util.dart';
import '../../utils/storage_util.dart';
import '../../utils/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

// ignore: constant_identifier_names
enum SettingsMenuItem { Feedback, About }

// ignore: constant_identifier_names
enum FollowType { ALL, USER, TOPIC, PRODUCT, APP }

// ignore: constant_identifier_names
enum ImageQuality { AUTO, ORIGIN, THUMBNAIL }

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final _settingsController = Get.put(SettingsController());
  String _version = '1.0.0(1)';

  void _getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = '${packageInfo.version}(${packageInfo.buildNumber})';
  }

  @override
  void initState() {
    super.initState();
    _getVersionInfo();
  }

  @override
  void dispose() {
    Get.delete<SettingsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        actions: [
          PopupMenuButton(
            onSelected: (SettingsMenuItem item) {
              switch (item) {
                case SettingsMenuItem.Feedback:
                  Utils.launchURL(Constants.URL_SOURCE_CODE);
                  break;
                case SettingsMenuItem.About:
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return MAboutDialog(version: _version);
                    },
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<SettingsMenuItem>(
                value: SettingsMenuItem.Feedback,
                child: const Text('反馈'),
              ),
              PopupMenuItem<SettingsMenuItem>(
                value: SettingsMenuItem.About,
                child: const Text('关于'),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          const ItemTitle(title: Constants.APP_NAME),
          const EdittextItem(
            icon: Icons.smartphone,
            title: '设备ID',
            boxKey: SettingsBoxKey.szlmId,
            needUpdateXAppDevice: true,
          ),
          ListTile(
            leading: const Icon(Icons.developer_mode),
            title: const Text('参数'),
            onTap: () => Get.toNamed('/params'),
          ),
          // Theme
          ListTile(
            title: Text(
              '主题',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SwitchItem(
            icon: Icons.palette_outlined,
            title: '动态主题',
            boxKey: SettingsBoxKey.useMaterial,
            defaultValue: true,
            forceAppUpdate: true,
          ),
          Visibility(
            visible: !GStorage.useMaterial,
            child: DropDownMenuItem(
              icon: Icons.format_color_fill,
              title: '主题颜色',
              boxKey: SettingsBoxKey.staticColor,
              items: Constants.themeType
                  .map((type) => DropdownMenuItem<int>(
                        value: Constants.themeType.indexOf(type),
                        child: Text(type),
                      ))
                  .toList(),
              forceAppUpdate: true,
            ),
          ),
          const DropDownMenuItem(
            icon: Icons.dark_mode_outlined,
            title: '深色模式',
            boxKey: SettingsBoxKey.selectedTheme,
            items: [
              DropdownMenuItem<int>(
                value: 1,
                child: Text('总是关闭'),
              ),
              DropdownMenuItem<int>(
                value: 2,
                child: Text('总是开启'),
              ),
              DropdownMenuItem<int>(
                value: 0,
                child: Text('跟随系统'),
              ),
            ],
            forceAppUpdate: true,
          ),
          // Display
          ListTile(
            title: Text(
              '显示',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            title: const Text('用户黑名单'),
            leading: const Icon(Icons.block),
            onTap: () => Get.toNamed(
              '/blacklist/',
              arguments: {'type': BlackListType.user},
            ),
          ),
          ListTile(
            title: const Text('话题黑名单'),
            leading: const Icon(Icons.block),
            onTap: () => Get.toNamed(
              '/blacklist/',
              arguments: {'type': BlackListType.topic},
            ),
          ),
          ListTile(
            title: const Text('字体大小'),
            subtitle: Text('${GStorage.fontScale.toStringAsFixed(2)}x'),
            leading: const Icon(Icons.text_fields),
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => SliderDialog(
                fontScale: GStorage.fontScale,
                setData: (newValue) {
                  GStorage.setFontScale(newValue);
                  Get.forceAppUpdate();
                },
              ),
            ),
          ),
          DropDownMenuItem(
            icon: Icons.add_circle_outline_outlined,
            title: '关注类型',
            boxKey: SettingsBoxKey.followType,
            items: FollowType.values
                .map((type) => DropdownMenuItem<int>(
                      value: FollowType.values.indexOf(type),
                      child: Text(type.name == 'ALL' ? '全部' :
                                 type.name == 'USER' ? '用户' :
                                 type.name == 'TOPIC' ? '话题' :
                                 type.name == 'PRODUCT' ? '产品' :
                                 type.name == 'APP' ? '应用' : type.name),
                    ))
                .toList(),
          ),
          /*
          DropDownMenuItem(
            icon: Icons.image_outlined,
            title: 'Image Quality',
            boxKey: SettingsBoxKey.imageQuality,
            items: ImageQuality.values
                .map((type) => DropdownMenuItem<int>(
                      value: ImageQuality.values.indexOf(type),
                      child: Text(type.name),
                    ))
                .toList(),
          ),
          const SwitchItem(
            icon: Icons.image_outlined,
            title: 'Image Dim',
            boxKey: SettingsBoxKey.imageDim,
            defaultValue: true,
          ),
          */
          const SwitchItem(
            icon: Icons.travel_explore,
            title: '在浏览器中打开',
            boxKey: SettingsBoxKey.openInBrowser,
            defaultValue: false,
          ),
          /*
          const SwitchItem(
            icon: Icons.feed_outlined,
            title: 'Show Square',
            boxKey: SettingsBoxKey.showSquare,
            defaultValue: true,
          ),
          */
          const SwitchItem(
            icon: Icons.history,
            title: '记录历史',
            boxKey: SettingsBoxKey.recordHistory,
            defaultValue: true,
          ),
          const SwitchItem(
            icon: Icons.emoji_emotions_outlined,
            title: '显示表情',
            boxKey: SettingsBoxKey.showEmoji,
            defaultValue: true,
          ),
          if (Platform.isAndroid)
            const SwitchItem(
              icon: Icons.system_update,
              title: '检查更新',
              boxKey: SettingsBoxKey.checkUpdate,
              defaultValue: true,
            ),
          // Others
          ListTile(
            title: Text(
              '其他',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            title: const Text('关于'),
            subtitle: Text(_version),
            leading: const Icon(Icons.all_inclusive),
            onTap: () =>
                Get.toNamed('/about', parameters: {'version': _version}),
          ),
          Obx(
            () => ListTile(
              title: const Text('清除缓存'),
              subtitle: _settingsController.cacheSize.value.isNotEmpty
                  ? Text(_settingsController.cacheSize.value)
                  : null,
              leading: const Icon(Icons.cleaning_services_outlined),
              onTap: () async {
                await _settingsController.getCacheSize();
                if (context.mounted) {
                  showDialog<void>(
                    context: context,
                    builder: (context) => ClearDialog(
                      cacheSize: _settingsController.cacheSize.value,
                      onClearCache: () async {
                        if (await CacheManage().clearCacheAll()) {
                          _settingsController.getCacheSize();
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsController extends GetxController {
  RxString cacheSize = ''.obs;

  Future<void> getCacheSize() async {
    final res = await CacheManage().loadApplicationCache();
    cacheSize.value = res;
  }

  @override
  void onInit() {
    super.onInit();
    getCacheSize();
  }
}
