import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../model/entities/material.dart';
import '../../model/use_cases/material_controller.dart';
import '../../extensions/exception_extension.dart';
import '../widgets/show_indicator.dart';

class EditMaterialPage extends HookConsumerWidget {
  const EditMaterialPage({Key? key, this.data}) : super(key: key);

  final MaterialData? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleEditingController = useTextEditingController(text: data?.title);
    final imageEditingController = useTextEditingController();
    final form = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('教材編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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
                    .update(data!.copyWith(title: titleEditingController.text));
                result.when(
                  success: () {},
                  failure: (e) {
                    print(e.errorMessage);
                  },
                );
              } else {
                final result = await ref
                    .read(materialDataProvider.notifier)
                    .create(titleEditingController.text);
                result.when(
                  success: () {},
                  failure: (e) {
                    print('失敗');
                    print(e.errorMessage);
                  },
                );
              }
              dismissIndicator(context);
              Navigator.of(context).pop();
            },
            child: const Text('登録'),
          ),
        ]),
      ),
    );
  }
}
