import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:learning_management_app/presentation/widgets/thumbnail.dart';

import '../../../model/entities/material.dart';
import '../../../model/use_cases/material_controller.dart';
import '../../../extensions/exception_extension.dart';
import '../../widgets/show_indicator.dart';
import '../image_viewer/image_viewer.dart';
import '../../../extensions/context_extension.dart';

class EditMaterialPage extends HookConsumerWidget {
  const EditMaterialPage({Key? key, this.data}) : super(key: key);

  final MaterialData? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final titleEditingController = useTextEditingController(text: data?.title);
    final imageEditingController = useTextEditingController();
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
            Thumbnail(
              height: mediaQuery.size.height * 0.3,
              width: mediaQuery.size.width * 0.4,
              url: data?.image?.url,
              onTap: () {
                final url = data?.image?.url;
                if (url != null) {
                  ImageViewer.show(
                    context,
                    urls: [url],
                    heroTag: 'profile',
                  );
                }
              },
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
                  if (data != null) {
                    final result = await ref
                        .read(materialDataProvider.notifier)
                        .update(
                            data!.copyWith(title: titleEditingController.text));
                    result.when(
                      success: () {},
                      failure: (e) {
                        showOkAlertDialog(context: context, title: e.errorMessage);
                      },
                    );
                  } else {
                    final result = await ref
                        .read(materialDataProvider.notifier)
                        .create(titleEditingController.text);
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
