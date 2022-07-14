import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../provider/record_provider.dart';
import '../../model/entities/record.dart';
import '../pages/edit_record_page.dart';
import './delete_dialog.dart';

class RecordItem extends HookConsumerWidget {
  const RecordItem({Key? key, required this.record, required this.materialName})
      : super(key: key);

  final Record record;
  final String materialName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            shape: BoxShape.circle,
          ),
          child: Center(child: Text('${record.learningTime}分')),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditRecordPage(record: record);
                  }));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteDialog(
                        title: '学習記録を削除してよろしいですか？',
                        content: 'このアクションは取り消せません。',
                        deleteHandle: () {
                          ref.watch(recordProvider.notifier).remove(record.id);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        title: Text(
          materialName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('yyyy/MM/dd').format(record.createdAt),
            style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
