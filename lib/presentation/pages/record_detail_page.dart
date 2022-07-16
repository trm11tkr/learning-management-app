import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/delete_dialog.dart';
import '../../provider/material_provider.dart';
import '../../provider/record_provider.dart';
import './edit_record_page.dart';

class RecordDetailPage extends HookConsumerWidget {
  const RecordDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final record = ref.watch(recordProvider.notifier).getById(id: id);
    final record =
        ref.watch(recordProvider).firstWhere((element) => element.id == id);
    final materialTitle =
        ref.watch(materialProvider.notifier).getById(record.materialId).title;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          materialTitle,
          softWrap: true,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EditRecordPage(
                  recordId: id,
                );
              }));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.7,
                  child: Column(
                    children: [
                      Container(
                        height: mediaQuery.size.height * 0.3,
                        width: mediaQuery.size.width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Center(child: Text('${record.learningTime}分')),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Text(
                          materialTitle,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                          '登録日：${DateFormat("yyyy/MM/dd").format(record.createdAt)}'),
                      Text(record.description ?? ''),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return DeleteDialog(
                          title: '学習記録を削除してよろしいですか？',
                          content: 'このアクションは取り消せません。',
                          deleteHandle: () {
                            ref.watch(materialProvider.notifier).remove(id);
                            ref
                                .watch(recordProvider.notifier)
                                .removeByMaterialId(id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    '削除',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
