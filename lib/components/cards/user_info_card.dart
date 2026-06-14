import 'dart:math';

import 'package:c001apk_flutter/components/network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import 'package:get/get.dart';

import '../../logic/model/feed/datum.dart';
import '../../pages/ffflist/ffflist_page.dart';
import '../../utils/date_util.dart';
import '../../utils/global_data.dart';
import '../../utils/storage_util.dart';
import '../../utils/utils.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
    required this.data,
    required this.onFollow,
  });

  final Datum data;
  final Function(dynamic uid, dynamic isFollow) onFollow;

  @override
  Widget build(BuildContext context) {
    bool darken = GStorage.getBrightness() == Brightness.light;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Map<dynamic, dynamic> arguments = {
                      "imgList": [data.cover],
                    };
                    Get.toNamed('/imageview', arguments: arguments);
                  },
                  child: networkImage(
                    data.cover.toString(),
                    width: double.infinity,
                    height: 125,
                    borderRadius: null,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            darken
                                ? const Color(0x8D000000)
                                : const Color(0x5DFFFFFF),
                            darken ? BlendMode.darken : BlendMode.lighten,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: double.infinity, height: 40)
              ],
            ),
            Positioned(
              top: 85,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Map<dynamic, dynamic> arguments = {
                    "imgList": [data.userAvatar],
                  };
                  Get.toNamed('/imageview', arguments: arguments);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: clipNetworkImage(
                    data.userAvatar ?? '',
                    isAvatar: true,
                    width: 76,
                    height: 76,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 128,
              right: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.outlined(
                    onPressed: () {
                      if (GlobalData().isLogin) {
                        int uid = data.uid;
                        int mUid = int.parse(GlobalData().uid);
                        String ukey = '${min(uid, mUid)}_${max(uid, mUid)}';
                        Get.toNamed('/chat', parameters: {
                          'ukey': ukey,
                          'uid': data.uid.toString(),
                          'username': data.username ?? '',
                        });
                      }
                    },
                    icon: const Icon(Icons.mail_outline, size: 21),
                    style: IconButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0.5),
                      ),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: -2,
                        vertical: -2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton.tonal(
                    onPressed: () {
                      if (GlobalData().isLogin) {
                        onFollow(data.uid, data.isFollow);
                      }
                    },
                    style: FilledButton.styleFrom(
                      visualDensity: const VisualDensity(
                        horizontal: -2,
                        vertical: -2,
                      ),
                    ),
                    child: Text(data.isFollow == 1 ? '取消关注' : '关注'),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: GestureDetector(
            onTap: () =>
                Utils.copyText(data.userInfo?.username ?? data.username ?? ''),
            child: Text(
              data.userInfo?.username ?? data.username ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Utils.copyText(data.uid.toString()),
                child: Text(
                  'UID: ${data.uid}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  'Lv.${data.level}',
                  style: TextStyle(
                    height: 1,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  strutStyle: const StrutStyle(
                    height: 1,
                    leading: 0,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.sell),
            const SizedBox(width: 5.0),
            Text((data.bio?.isEmpty ?? true) ? '这个人很懒，什么都没写' : data.bio!),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4),
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '${data.feed} ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '动态   '),
                    TextSpan(
                        text: '${data.beLikeNum} ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '赞   '),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(
                  '/ffflist',
                  arguments: {
                    'type': FFFListType.USER_FOLLOW,
                    'uid': data.uid.toString(),
                  },
                ),
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: '${data.follow} ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '关注   '),
                  ],
                )),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(
                  '/ffflist',
                  arguments: {
                    'type': FFFListType.FAN,
                    'uid': data.uid.toString(),
                  },
                ),
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                        text: '${data.fans} ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '粉丝'),
                  ],
                )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4),
          child: (data.gender == 0 || data.gender == 1)
              ? Row(
                  children: [
                    Icon(data.gender == 1 ? Icons.male : Icons.female,
                        size: 20.0),
                    SizedBox(width: 5),
                    Text(AppStrings.of(context).active(DateUtil.fromToday(data.logintime))),
                  ],
                )
              : Text(AppStrings.of(context).active(DateUtil.fromToday(data.logintime))),
        ),
      ],
    );
  }
}
