import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../provider/material_provider.dart';
import '../../provider/record_provider.dart';

class DeleteDialog extends ConsumerWidget {
  const DeleteDialog({
    Key? key,
    required this.title,
    required this.materialId,
  }) : super(key: key);

  final String title;
  final String materialId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        '「$title」を削除してよろしいですか？',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: Text(
        '$titleによる学習記録は全て削除されます。',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(
            '削除',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          onPressed: () {
            ref.watch(materialProvider.notifier).remove(materialId);
            ref.watch(recordProvider.notifier).removeByMaterialId(materialId);
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
