import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../provider/record_provider.dart';
import '../pages/edit_record_page.dart';
import './delete_dialog.dart';
import '../pages/record_detail_page.dart';

class RecordItem extends HookConsumerWidget {
  const RecordItem({
    Key? key,
    required this.id,
    required this.learningTime,
    required this.materialName,
    required this.createdAt,
  }) : super(key: key);

  final String id;
  final int learningTime;
  final String materialName;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RecordDetailPage(id: id);
        }));
      },
      child: Card(
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
            child: Center(child: Text('$learningTime分')),
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
                      return EditRecordPage(recordId: id);
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
                            ref.watch(recordProvider.notifier).remove(id);
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
          subtitle: Text(
            DateFormat('yyyy/MM/dd').format(createdAt),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
