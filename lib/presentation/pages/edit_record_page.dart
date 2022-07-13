import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../provider/record_provider.dart';
import '../../model/entities/record.dart';
import '../../provider/material_provider.dart';

class EditRecordPage extends HookConsumerWidget {
  const EditRecordPage({Key? key, this.record}) : super(key: key);

  final Record? record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialData = ref.watch(materialProvider);
    final timerController = useTextEditingController();
    final materialController = useTextEditingController();
    final form = GlobalKey<FormState>();

    useEffect(() {
      if (record != null) {
        materialController.text = ref
            .watch(materialProvider.notifier)
            .getById(record!.materialId)
            .title;
        timerController.text = record!.learningTime.toString();
      }
    }, const []);

    void showPicker({
      required controller,
      required List<String> pickerItems,
      required List<String> settingValues,
    }) {
      var selectedIndex = 0;

      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 300,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                magnification: 1.2,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 40,
                children: pickerItems.map((item) => Text(item)).toList(),
                onSelectedItemChanged: (int index) {
                  selectedIndex = index;
                },
              ),
            ),
          );
        },
      ).then((_) {
        controller.text = pickerItems[selectedIndex];
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: record == null ? const Text('登録') : const Text('編集')
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: materialController,
                    decoration: const InputDecoration(label: Text('学習教材')),
                    onTap: () {
                      // キーボードが出ないようにする
                      FocusScope.of(context).requestFocus(FocusNode());

                      showPicker(
                        controller: materialController,
                        pickerItems: materialData
                            .map((material) => material.title)
                            .toList(),
                        settingValues: materialData
                            .map((material) => material.id)
                            .toList(),
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '学習教材を選択してください。';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: timerController,
                    decoration: const InputDecoration(label: Text('学習時間')),
                    onTap: () {
                      // キーボードが出ないようにする
                      FocusScope.of(context).requestFocus(FocusNode());
                      final settingValues = [
                        '30',
                        '60',
                        '90',
                        '120',
                        '150',
                        '180',
                        '210',
                        '240',
                        '300'
                      ];
                      showPicker(
                          controller: timerController,
                          pickerItems:
                              settingValues.map((value) => '$value分').toList(),
                          settingValues: settingValues,);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '学習時間を選択してください。';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (form.currentState?.validate() != true) {
                      return;
                    }
                    if (record != null) {
                      ref.watch(recordProvider.notifier).edit(
                            recordId: record!.id,
                            materialId: ref
                                .watch(materialProvider.notifier)
                                .getByTitle(materialController.text),
                            learningTime: int.parse(
                              timerController.text.replaceFirst("分", ""),
                            ),
                          );
                    } else {
                      ref.watch(recordProvider.notifier).add(
                            materialId: ref
                                .watch(materialProvider.notifier)
                                .getByTitle(materialController.text),
                            learningTime: int.parse(
                              timerController.text.replaceFirst("分", ""),
                            ),
                          );
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('登録'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
