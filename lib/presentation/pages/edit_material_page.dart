import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:learning_management_app/provider/material_provider.dart';

class EditMaterialPage extends HookConsumerWidget {
  const EditMaterialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _titleEditingController = useTextEditingController();
    final _imageEditingController = useTextEditingController();

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
          TextField(
            controller: _titleEditingController,
            decoration: const InputDecoration(
              labelText: 'TOEIC 出る単特急 金のフレーズ',
            ),
            onSubmitted: (value) {
              ref.watch(materialProvider.notifier).add(value);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () {
              ref
                  .watch(materialProvider.notifier)
                  .add(_titleEditingController.text);
              Navigator.of(context).pop();
            },
            child: const Text('登録'),
          ),
        ]),
      ),
    );
  }
}
