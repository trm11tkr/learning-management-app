import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/thumbnail.dart';
import '../../../model/entities/material.dart';
import '../../../model/use_cases/material/material_controller.dart';
import '../../../model/use_cases/record_controller.dart';
import 'edit_material_page.dart';
import '../../widgets/show_indicator.dart';
import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';

class MaterialDetailPage extends HookConsumerWidget {
  const MaterialDetailPage({
    Key? key,
    required this.material,
  }) : super(key: key);

  final MaterialData material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(materialDataProvider);
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
                  onPressed: () async {
                    final alertResult = await showOkCancelAlertDialog(
                        context: context,
                        
                        title: '「${material.title}」を削除してよろしいですか？',
                        message: '${material.title}による学習記録は全て削除されます。');

                    if (alertResult == OkCancelResult.cancel) {
                      return;
                    }
                    showIndicator(context);
                    final recordDeleteResult = await ref
                        .watch(materialDataProvider.notifier)
                        .remove(material.id);

                    recordDeleteResult.when(
                        success: () {},
                        failure: (e) {
                          context.showSnackBar(
                            e.errorMessage,
                          );
                        });

                    final materialDeleteResult = await ref
                        .watch(recordProvider.notifier)
                        .removeByMaterialId(material.id);

                    materialDeleteResult.when(success: () {
                      context.showSnackBar('削除しました');
                    }, failure: (e) {
                      context.showSnackBar(
                        e.errorMessage,
                      );
                    });
                    dismissIndicator(context);
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
