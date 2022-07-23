import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

import '../../widgets/record_item.dart';
import '../../../model/entities/record.dart';
import '../../../model/use_cases/record_controller.dart';
import './edit_record_page.dart';
import '../../widgets/chart.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../../extensions/exception_extension.dart';
import '../../../model/use_cases/my_profile/fetch_my_profile.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchMyProfileProvider).value;
    final List<Record> recordList = ref.watch(recordProvider);
    final List<Record> recentRecordList =
        ref.watch(recordProvider.notifier).recentRecords;
    final mediaQuery = MediaQuery.of(context);

    /// カスタムフック
    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(recordProvider.notifier).fetch();
        result.when(
          success: () {},
          failure: (e) {
            showOkAlertDialog(context: context, title: e.errorMessage);
          },
        );
      });
      return null;
    });

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: const EdgeInsets.only(top: 8, left: 5, right: 5),
              elevation: 5,
              child: Text(
                '目標学習時間:${profile?.targetTime}分/日',
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
            child: Chart(
                recentRecord: recentRecordList,
                targetDayTime: profile?.targetTime ?? 0),
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
