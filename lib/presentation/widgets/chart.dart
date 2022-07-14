import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/entities/record.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentRecord}) : super(key: key);

  // 1週間分のトランザクション
  final List<Record> recentRecord;

  // 1週間分の学習時間を計算
  List<Map<String, dynamic>> get groupedRecordValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;

      // Listの生成順に1週間を遡り、トラザクションと日付を比較
      for (var record in recentRecord) {
        // 日付が一致すれば料金を加算
        if (record.createdAt.day == weekDay.day &&
            record.createdAt.month == weekDay.month &&
            record.createdAt.year == weekDay.year) {
          totalSum += record.learningTime;
        }
      }
      return {'day': DateFormat.E('ja').format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  // 出費の合計を計算
  double get totalLearning {
    return groupedRecordValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedRecordValues.map(
            (record) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: record['day'],
                    spendingAmount: record['amount'],
                    spendingPctOfTotal: totalLearning == 0.0
                        ? 0.0
                        : record['amount'] / totalLearning),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
