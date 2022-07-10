import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_management_app/provider/material_provider.dart';

import '../widgets/record_item.dart';
import '../../model/entities/record.dart';
import '../../provider/record_provider.dart';
import '../../provider/material_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Record> recordList = ref.watch(recordProvider);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final materialName = ref
              .watch(materialProvider.notifier)
              .getById(recordList[index].materialId)
              .title;
          return RecordItem(
            record: recordList[index],
            materialName: materialName,
          );
        },
        itemCount: recordList.length,
      ),
    );
  }
}
