import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/delete_dialog.dart';
import '../../provider/material_provider.dart';
import '../../provider/record_provider.dart';

class MaterialDetailPage extends ConsumerWidget {
  const MaterialDetailPage({
    Key? key,
    required this.id,
    required this.title,
    required this.createdAt,
    this.imageUrl,
  }) : super(key: key);

  final String id;
  final String title;
  final DateTime createdAt;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          softWrap: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
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
                      child: imageUrl == null
                          ? const Icon(Icons.image)
                          : const Icon(Icons.image),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('登録日：${DateFormat("yyyy/MM/dd").format(createdAt)}'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteDialog(
                        title: '「$title」を削除してよろしいですか？',
                        content: '$titleによる学習記録は全て削除されます。',
                        deleteHandle: () {
                          ref.watch(materialProvider.notifier).remove(id);
                          ref
                              .watch(recordProvider.notifier)
                              .removeByMaterialId(id);
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
    );
  }
}
