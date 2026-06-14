import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../constants/app_strings.dart';

import '../constants/constants.dart';
import '../utils/utils.dart';

class SliderDialog extends StatefulWidget {
  const SliderDialog(
      {super.key, required this.fontScale, required this.setData});

  final double fontScale;
  final Function(double newValue) setData;

  @override
  State<SliderDialog> createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  late double _fontScale;

  @override
  void initState() {
    super.initState();
    _fontScale = widget.fontScale;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(AppStrings.of(context).fontScale)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            min: 0.5,
            max: 2.0,
            value: _fontScale,
            secondaryTrackValue: 1,
            onChanged: (value) => setState(() => _fontScale = value),
          ),
          Text(
            'Font Size: ${_fontScale.toStringAsFixed(2)}x',
            style: TextStyle(fontSize: 15 * _fontScale),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.setData(1.00);
            Get.back();
          },
          child: Text(AppStrings.of(context).reset),
        ),
        TextButton(
          onPressed: () {
            widget.setData(_fontScale);
            Get.back();
          },
          child: Text(AppStrings.of(context).ok),
        ),
      ],
    );
  }
}

class EditTextDialog extends StatelessWidget {
  const EditTextDialog({
    super.key,
    required this.title,
    required this.defaultText,
    required this.setData,
  });

  final String title;
  final String defaultText;
  final Function(String value) setData;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController.fromValue(
      TextEditingValue(
        text: defaultText,
        selection: TextSelection.fromPosition(
          TextPosition(
              affinity: TextAffinity.downstream, offset: defaultText.length),
        ),
      ),
    );
    return AlertDialog(
      title: Center(child: Text(title)),
      content: TextField(
        autofocus: true,
        controller: controller,
        onSubmitted: (value) {
          setData(value);
          Navigator.pop(context);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(AppStrings.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            setData(controller.text);
            Get.back();
          },
          child: Text(AppStrings.of(context).ok),
        ),
      ],
    );
  }
}

class MAboutDialog extends StatelessWidget {
  const MAboutDialog({super.key, required this.version});

  final String version;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.all_inclusive),
          const SizedBox(width: 12.0),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HtmlWidget(
                  '''
                  <font size="6">${Constants.APP_NAME}</font><br>
                  $version<br><br>
                  View source code at <b><a href="${Constants.URL_SOURCE_CODE}">GitHub</a></b>
                  ''',
                  onTapUrl: (url) {
                    Utils.launchURL(url);
                    return true;
                  },
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          child: const Text('查看许可'),
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: Constants.APP_NAME,
              applicationVersion: '1.0.0',
              applicationIcon: const Icon(Icons.all_inclusive),
            );
          },
        ),
        TextButton(
          child: const Text('关闭'),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}

class ClearDialog extends StatelessWidget {
  const ClearDialog(
      {super.key, required this.cacheSize, required this.onClearCache});

  final String cacheSize;
  final Function() onClearCache;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('清除缓存')),
      content: Text('当前缓存大小: $cacheSize'),
      actions: [
        TextButton(
          child: Text(AppStrings.of(context).cancel),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: Text(AppStrings.of(context).ok),
          onPressed: () {
            onClearCache();
            Get.back();
          },
        ),
      ],
    );
  }
}
