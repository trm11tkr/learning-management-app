import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
