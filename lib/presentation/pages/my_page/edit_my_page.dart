import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/thumbnail.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../custom_hooks/use_form_field_state_key.dart';
import '../../widgets/show_indicator.dart';
import '../../../model/use_cases/my_profile/fetch_my_profile.dart';
import '../../../model/use_cases/image_compress.dart';
import '../../../model/use_cases/my_profile/save_my_profile_image.dart';
import '../../../model/use_cases/my_profile/save_my_profile.dart';
import '../../../extensions/context_extension.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/sheets/show_photo_and_crop_bottom_sheet.dart';
import '../../../utils/logger.dart';

class EditMyPage extends HookConsumerWidget {
  const EditMyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);

    final profile = ref.watch(fetchMyProfileProvider).value;
    final targetTimeState = useState<int?>(null);

    /// カスタムフック
    final nameFormKey = useFormFieldStateKey();
    final targetTimeFormKey = useFormFieldStateKeyWithInt();

    useEffectOnce(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nameFormKey.currentState?.didChange(profile?.name);
        targetTimeFormKey.currentState?.didChange(profile?.targetTime);
        targetTimeState.value = profile?.targetTime;
      });
      return null;
    });

    void showPicker({
      required List<String> pickerItems,
      required List<String> settingValues,
    }) {
      var selectedIndex = 0;

      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 300,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                magnification: 1.2,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 40,
                children: pickerItems
                    .map((item) => Container(
                          width: mediaQuery.size.width * 0.7,
                          child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ))
                    .toList(),
                onSelectedItemChanged: (int index) {
                  selectedIndex = index;
                },
              ),
            ),
          );
        },
      ).then((_) {
        targetTimeState.value = int.parse(settingValues[selectedIndex]);
        targetTimeFormKey.currentState
            ?.didChange(int.parse(pickerItems[selectedIndex]));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール変更'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final selectedImage = await showPhotoAndCropBottomSheet(
                context,
                title: 'プロフィール画像',
              );
              if (selectedImage == null) {
                return;
              }

              // 圧縮して設定
              final compressImage =
                  await ref.read(imageCompressProvider)(selectedImage);
              if (compressImage == null) {
                return;
              }

              try {
                showIndicator(context);
                await ref.read(saveMyProfileImageProvider).call(compressImage);
              } on Exception catch (e) {
                logger.shout(e);
                await showOkAlertDialog(
                  context: context,
                  title: '画像を保存できませんでした',
                );
              } finally {
                dismissIndicator(context);
              }
            },
            child: CircleThumbnail(
              size: 96,
              url: profile?.image?.url,
            ),
          ),
          const SizedBox(height: 8),

          // 入力フォーム
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child:
                    Text('名前', style: Theme.of(context).textTheme.bodyMedium),
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: '名前を入力してください',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                  isDense: true,
                  counterText: '',
                ),
                key: nameFormKey,
                initialValue: profile?.name,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? '名前を入力してください'
                    : null,
                maxLength: 32,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('目標学習時間',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              TextFormField(
                textAlign: TextAlign.end,
                initialValue: '${profile?.targetTime}分',
                decoration: const InputDecoration(label: Text('学習時間')),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final settingValues = [
                    '15',
                    '30',
                    '60',
                    '90',
                    '120',
                    '150',
                    '180',
                    '210',
                    '240',
                    '300'
                  ];
                  showPicker(
                    pickerItems:
                        settingValues.map((value) => '$value分').toList(),
                    settingValues: settingValues,
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '学習時間を選択してください。';
                  }
                  return null;
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: RoundedButton(
              elevation: 2,
              onTap: () async {
                context.hideKeyboard();
                if (!nameFormKey.currentState!.validate()) {
                  return;
                }
                final name = nameFormKey.currentState?.value?.trim() ?? '';
                final targetTime = targetTimeState.value;
                try {
                  showIndicator(context);
                  await ref.read(saveMyProfileProvider).call(
                        name: name,
                        targetTime: targetTime,
                      );
                  dismissIndicator(context);
                  context.showSnackBar('保存しました');
                  Navigator.of(context).pop();
                } on Exception catch (e) {
                  logger.shout(e);
                  dismissIndicator(context);
                  await showOkAlertDialog(
                      context: context, title: '保存できませんでした');
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  '保存する',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
