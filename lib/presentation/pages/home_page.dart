import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/record_item.dart';
import '../../model/entities/record.dart';
import '../../model/use_cases/record_controller.dart';
import '../pages/edit_record_page.dart';
import '../widgets/chart.dart';
import '../custom_hooks/use_effect_once.dart';
import '../../extensions/exception_extension.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Record> recordList = ref.watch(recordProvider);
    final List<Record> recentRecordList =
        ref.watch(recordProvider.notifier).recentRecords;
    final mediaQuery = MediaQuery.of(context);
    const targetDayTime = 60;

    /// カスタムフック
    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(recordProvider.notifier).fetch();
        result.when(
          success: () {},
          failure: (e) {
            print(e.errorMessage);
          },
        );
      });
      return null;
    });

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
            child: Chart(
                recentRecord: recentRecordList, targetDayTime: targetDayTime),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return RecordItem(data: recordList[index]);
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
