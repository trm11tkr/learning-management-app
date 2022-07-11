import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../model/entities/record.dart';
import '../widgets/materials_drop_down.dart';

class EditRecordPage extends HookConsumerWidget {
  const EditRecordPage({Key? key, this.record}) : super(key: key);

  final Record? record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialsDropDown(materialId: record?.materialId),
          ],
        ),
      ),
    );
  }
}
