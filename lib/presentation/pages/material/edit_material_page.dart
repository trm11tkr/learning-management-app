import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../model/use_cases/material/save_material_image.dart';
import '../../widgets/thumbnail.dart';
import '../../../model/entities/material.dart';
import '../../../model/use_cases/image_compress.dart';
import '../../../model/use_cases/material/material_controller.dart';
import '../../../extensions/exception_extension.dart';
import '../../widgets/show_indicator.dart';
import '../image_viewer/image_viewer.dart';
import '../../../extensions/context_extension.dart';
import '../../widgets/sheets/show_photo_and_crop_bottom_sheet.dart';
import '../../../utils/logger.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../custom_hooks/use_form_field_state_key.dart';

class EditMaterialPage extends HookConsumerWidget {
  const EditMaterialPage({Key? key, this.material}) : super(key: key);

  final MaterialData? material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final titleEditingController =
        useTextEditingController(text: material?.title);

    /// カスタムフック
    final titleFormKey = useFormFieldStateKey();

    final materialIdState = useState<String?>(material?.id);
    final showImageState = useState<File?>(null);
    final uint8ListState = useState<Uint8List?>(null);

    useEffectOnce(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        titleFormKey.currentState?.didChange(material?.title);
      });
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('教材編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final selectedImage = await showPhotoAndCropBottomSheet(
                  context,
                  title: 'サムネイル',
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
              child: showImageState.value == null
                  ? Thumbnail(
                      height: mediaQuery.size.height * 0.3,
                      width: mediaQuery.size.width * 0.4,
                      url: material?.image?.url)
                  : Thumbnail(
                      height: mediaQuery.size.height * 0.3,
                      width: mediaQuery.size.width * 0.4,
                      file: showImageState.value),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Form(
                child: TextFormField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                    hintText: 'TOEIC 出る単特急 金のフレーズ',
                    isDense: true,
                  ),
                  key: titleFormKey,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'タイトル正しく入力してください'
                      : null,
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (titleFormKey.currentState?.validate() != true) {
                    return;
                  }
                  showIndicator(context);
                  if (material != null) {
                    final result = await ref
                        .read(materialDataProvider.notifier)
                        .update(material!
                            .copyWith(title: titleEditingController.text));
                    result.when(
                      success: () {
                        logger.info('Recordを無事に更新');
                      },
                      failure: (e) {
                        showOkAlertDialog(
                            context: context, title: e.errorMessage);
                      },
                    );
                  } else {
                    final result = await ref
                        .read(materialDataProvider.notifier)
                        .create(title: titleEditingController.text);
                    result.when(
                      success: (materialId) {
                        logger.info('Recordを無事に作成');
                        materialIdState.value = materialId;
                        context.showSnackBar('更新しました');
                      },
                      failure: (e) {
                        showOkAlertDialog(
                            context: context, title: e.errorMessage);
                      },
                    );
                  }

                  if (materialIdState.value != null &&
                      uint8ListState.value != null) {
                    await ref
                        .read(saveMaterialImageProvider)
                        .call(materialIdState.value!, uint8ListState.value!);
                  }
                  dismissIndicator(context);
                  Navigator.of(context).pop();
                },
                child: const Text('登録'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
