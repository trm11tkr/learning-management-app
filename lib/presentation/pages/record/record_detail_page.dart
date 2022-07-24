import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

import '../../../model/use_cases/material/material_controller.dart';
import '../../../model/entities/record.dart';
import '../../../model/use_cases/record_controller.dart';
import './edit_record_page.dart';
import '../../widgets/show_indicator.dart';
import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';

class RecordDetailPage extends HookConsumerWidget {
  const RecordDetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Record? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(recordProvider);
    final materialTitle = data != null
        ? ref
            .watch(materialDataProvider.notifier)
            .getById(data!.materialId)
            .title
        : '';
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
                  data: data,
                );
              }));
            },
          )
        ],
      ),
      body: data == null
          ? const SizedBox()
          : Padding(
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
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child:
                                  Center(child: Text('${data?.learningTime}分')),
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
                            data == null
                                ? const SizedBox()
                                : Text('登録日：${data?.dateLabel}'),
                            Text(data?.description ?? ''),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final alertResult = await showOkCancelAlertDialog(
                            context: context,
                            title: 'この学習記録を削除してよろしいですか？',
                          
                          );

                          if (alertResult == OkCancelResult.cancel) {
                            return;
                          }
                          showIndicator(context);

                          if (data == null) {
                            return;
                          }
                          final result = await await ref
                              .watch(recordProvider.notifier)
                              .remove(data!.id);

                          result.when(success: () {
                            context.showSnackBar('削除しました');
                          }, failure: (e) {
                            context.showSnackBar(
                              e.errorMessage,
                            );
                          });

                          dismissIndicator(context);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
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
