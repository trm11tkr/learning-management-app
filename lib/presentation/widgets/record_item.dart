import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:learning_management_app/model/use_cases/material_controller.dart';

import '../pages/record_detail_page.dart';
import '../../model/entities/record.dart';
import '../../extensions/date_extension.dart';

class RecordItem extends ConsumerWidget {
  const RecordItem({Key? key, required this.data}) : super(key: key);

  final Record data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RecordDetailPage(data: data);
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
            child: Center(child: Text('${data.learningTime}分')),
          ),
          title: Text(
            ref
                .watch(materialDataProvider.notifier)
                .getById(data.materialId)
                .title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            data.dateLabel,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
