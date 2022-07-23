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

class EditMaterialPage extends HookConsumerWidget {
  const EditMaterialPage({Key? key, this.material}) : super(key: key);

  final MaterialData? material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final titleEditingController = useTextEditingController(text: material?.title);
    final form = GlobalKey<FormState>();

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
                title: '教材画像',
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
                await ref.read(saveMaterialImageProvider).call(material!.id, compressImage);
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
              child: Thumbnail(
                height: mediaQuery.size.height * 0.3,
                width: mediaQuery.size.width * 0.4,
                url: material?.image?.url,
                onTap: () {
                  final url = material?.image?.url;
                  if (url != null) {
                    ImageViewer.show(
                      context,
                      urls: [url],
                      heroTag: 'material',
                    );
                  }
                },
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Form(
                key: form,
                child: TextFormField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                    hintText: 'TOEIC 出る単特急 金のフレーズ',
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'タイトル正しく入力してください'
                      : null,
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (form.currentState?.validate() != true) {
                    return;
                  }
                  showIndicator(context);
                  if (material != null) {
                    final result = await ref
                        .read(materialDataProvider.notifier)
                        .update(
                            material!.copyWith(title: titleEditingController.text));
                    result.when(
                      success: () {},
                      failure: (e) {
                        showOkAlertDialog(context: context, title: e.errorMessage);
                      },
                    );
                  } else {
                    final result = await ref
                        .read(materialDataProvider.notifier)
                        .create(title:titleEditingController.text);
                    result.when(
                      success: () {
                        context.showSnackBar('更新しました');
                      },
                      failure: (e) {
                        showOkAlertDialog(context: context, title: e.errorMessage);
                      },
                    );
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
