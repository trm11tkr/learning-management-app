import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/int_extension.dart';
import '../../../model/use_cases/my_profile/fetch_my_profile.dart';
import '../../../model/use_cases/image_compress.dart';
import '../../../model/use_cases/my_profile/save_my_profile_image.dart';
import '../../../model/use_cases/my_profile/save_my_profile.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../custom_hooks/use_form_field_state_key.dart';
import '../../widgets/show_indicator.dart';
import '../../widgets/thumbnail.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/sheets/show_photo_and_crop_bottom_sheet.dart';
import '../../widgets/show_picker.dart';
import '../../../utils/logger.dart';

final _key = GlobalKey<FormState>();

class EditMyPage extends HookConsumerWidget {
  const EditMyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);

    final profile = ref.watch(fetchMyProfileProvider).value;
    final targetTimeState = useState<int?>(null);
    final showImageState = useState<File?>(null);
    final uint8ListState = useState<Uint8List?>(null);

    final timerController = useTextEditingController();

    /// カスタムフック
    final nameFormKey = useFormFieldStateKey();

    useEffectOnce(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nameFormKey.currentState?.didChange(profile?.name);
        targetTimeState.value = profile?.targetTime;
        timerController.text = profile?.targetTime?.toHMString() ?? '';
      });
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール変更'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
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
                  showImageState.value = selectedImage;
                  uint8ListState.value = compressImage;
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      foregroundDecoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircleThumbnail(
                        fit: BoxFit.cover,
                        url: showImageState.value == null
                            ? profile?.image?.url
                            : null,
                        file: showImageState.value,
                      ),
                    ),
                    const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // 入力フォーム
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('名前', style: Theme.of(context).textTheme.bodyMedium),
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
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? '名前を入力してください'
                              : null,
                      maxLength: 32,
                    ),
                    const SizedBox(height: 24),
                    Text('目標学習時間',
                        style: Theme.of(context).textTheme.bodyMedium),
                    TextFormField(
                      textAlign: TextAlign.end,
                      controller: timerController,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () async {
                        await showPickerNumberFormatValue(
                          context: context,
                          title: '目標学習時間',
                          selectedStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ).then((value) {
                          if (value != null) {
                            targetTimeState.value = value;
                            timerController.text = value.toHMString();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedButton(
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
                    if (uint8ListState.value != null) {
                      await ref
                          .read(saveMyProfileImageProvider)
                          .call(uint8ListState.value!);
                    }
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
            ],
          ),
        ),
      ),
    );
  }
}
