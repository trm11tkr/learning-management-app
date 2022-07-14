import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/material_provider.dart';
import '../widgets/record_item.dart';
import '../../model/entities/record.dart';
import '../../provider/record_provider.dart';
import '../pages/edit_record_page.dart';
import '../widgets/chart.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Record> recordList = ref.watch(recordProvider);
    final List<Record> recentRecordList =
        ref.watch(recordProvider.notifier).recentRecords;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
            child: Chart(recentRecord: recentRecordList),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final materialName = ref
                    .watch(materialProvider.notifier)
                    .getById(recordList[index].materialId)
                    .title;
                return RecordItem(
                    id: recordList[index].id,
                    learningTime: recordList[index].learningTime,
                    materialName: materialName,
                    createdAt: recordList[index].createdAt);
              },
              itemCount: recordList.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const EditRecordPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
