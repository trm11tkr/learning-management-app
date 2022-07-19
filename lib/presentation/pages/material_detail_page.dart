import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/delete_dialog.dart';
import '../../model/entities/material.dart';
import '../../model/use_cases/material_controller.dart';
import '../../model/use_cases/record_controller.dart';
import './edit_material_page.dart';
import '../widgets/show_indicator.dart';

class MaterialDetailPage extends HookConsumerWidget {
  const MaterialDetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final MaterialData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title,
          softWrap: true,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EditMaterialPage(
                  data: data,
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
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: data.image == null
                            ? const Icon(Icons.image)
                            : const Icon(Icons.image),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Text(
                          data.title,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('登録日：${data.dateLabel}'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return DeleteDialog(
                          title: '「${data.title}」を削除してよろしいですか？',
                          content: '${data.title}による学習記録は全て削除されます。',
                          deleteHandle: () {
                            showIndicator(context);
                            ref
                                .watch(materialDataProvider.notifier)
                                .remove(data.id);
                            ref
                                .watch(recordProvider.notifier)
                                .removeByMaterialId(data.id);
                            dismissIndicator(context);
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
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
