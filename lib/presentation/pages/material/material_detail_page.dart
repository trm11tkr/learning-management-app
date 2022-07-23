import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_management_app/presentation/widgets/thumbnail.dart';

import '../../widgets/delete_dialog.dart';
import '../../../model/entities/material.dart';
import '../../../model/use_cases/material/material_controller.dart';
import '../../../model/use_cases/record_controller.dart';
import 'edit_material_page.dart';
import '../../widgets/show_indicator.dart';

class MaterialDetailPage extends HookConsumerWidget {
  const MaterialDetailPage({
    Key? key,
    required this.material,
  }) : super(key: key);

  final MaterialData material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          material.title,
          softWrap: true,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EditMaterialPage(
                  material: material,
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
                      Thumbnail(
                        height: mediaQuery.size.height * 0.3,
                        width: mediaQuery.size.width * 0.4,
                        url: material.image?.url,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Text(
                          material.title,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('登録日：${material.dateLabel}'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return DeleteDialog(
                          title: '「${material.title}」を削除してよろしいですか？',
                          content: '${material.title}による学習記録は全て削除されます。',
                          deleteHandle: () {
                            showIndicator(context);
                            ref
                                .watch(materialDataProvider.notifier)
                                .remove(material.id);
                            ref
                                .watch(recordProvider.notifier)
                                .removeByMaterialId(material.id);
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
