import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../provider/material_provider.dart';
import '../../model/entities/material.dart';

class EditMaterialPage extends HookConsumerWidget {
  const EditMaterialPage({Key? key, this.material}) : super(key: key);

  final MaterialData? material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleEditingController = useTextEditingController();
    final imageEditingController = useTextEditingController();
    final form = GlobalKey<FormState>();

    useEffect(() {
      if (material != null) {
        titleEditingController.text = material?.title ?? '';
        imageEditingController.text = material?.title ?? '';
      }
    }, const []);

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
                labelText: 'TOEIC 出る単特急 金のフレーズ',
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'タイトル正しく入力してください'
                  : null,
            ),
          ),
          TextButton(
            onPressed: () {
              if (form.currentState?.validate() != true) {
                return;
              }
              if (material != null) {
                ref.watch(materialProvider.notifier).edit(
                    materialId: material!.id,
                    title: titleEditingController.text);
              } else {
                ref
                    .watch(materialProvider.notifier)
                    .add(titleEditingController.text);
              }
              Navigator.of(context).pop();
            },
            child: const Text('登録'),
          ),
        ]),
      ),
    );
  }
}
