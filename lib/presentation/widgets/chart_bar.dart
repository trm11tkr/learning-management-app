import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {Key? key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal})
      : super(key: key);

  final String label; // 曜日
  final int spendingAmount; // 合計学習時間
  final double spendingPctOfTotal; // 1週間の学習時間に対する割合

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text('$spendingAmount分'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SizedBox(
                height: constraints.maxHeight * 0.6,
                width: constraints.maxHeight * 0.05,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                            color: spendingPctOfTotal == 1.0
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).errorColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
