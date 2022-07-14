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
    const targetDayTime = 60;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: const Card(
              margin: EdgeInsets.only(top: 8, left: 5, right: 5),
              elevation: 5,
              child: Text(
                '目標学習時間:$targetDayTime分/日',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
            child: Chart(recentRecord: recentRecordList, targetDayTime: targetDayTime),
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
