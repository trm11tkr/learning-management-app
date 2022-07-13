import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../provider/record_provider.dart';
import '../../model/entities/record.dart';
import '../../provider/material_provider.dart';
import '../pages/edit_material_page.dart';



final _key = GlobalKey<FormState>();

class EditRecordPage extends HookConsumerWidget {
  const EditRecordPage({Key? key, this.record}) : super(key: key);

  final Record? record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final materialData = ref.watch(materialProvider);
    final timerController = useTextEditingController();
    final materialController = useTextEditingController();
    final descriptionController = useTextEditingController();

    useEffect(() {
      if (record != null) {
        materialController.text = ref
            .watch(materialProvider.notifier)
            .getById(record!.materialId)
            .title;
        timerController.text = record!.learningTime.toString();
        descriptionController.text = record!.description.toString();
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
                children: pickerItems
                    .map((item) => Container(
                          width: mediaQuery.size.width * 0.7,
                          child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ))
                    .toList(),
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
      appBar:
          AppBar(title: record == null ? const Text('登録') : const Text('編集')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  textAlign: TextAlign.end,
                  controller: materialController,
                  decoration: const InputDecoration(label: Text('学習教材')),
                  onTap: () {
                    //     // キーボードが出ないようにする
                    FocusScope.of(context).requestFocus(FocusNode());
                    showPicker(
                      controller: materialController,
                      pickerItems: materialData
                          .map((material) => material.title)
                          .toList(),
                      settingValues:
                          materialData.map((material) => material.id).toList(),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '学習教材を選択してください。';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const EditMaterialPage();
                    }));
                  },
                  child: const Text('教材の追加'),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
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
                      settingValues: settingValues,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '学習時間を選択してください。';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      label: Text('メモ'), hintText: '過去問を3週した。'),
                ),
                TextButton(
                  onPressed: () {
                    if (_key.currentState?.validate() != true) {
                      return;
                    }
                    _key.currentState?.save();
                    if (record != null) {
                      ref.watch(recordProvider.notifier).edit(
                            recordId: record!.id,
                            materialId: ref
                                .watch(materialProvider.notifier)
                                .getByTitle(materialController.text),
                            learningTime: int.parse(
                              timerController.text.replaceFirst("分", ""),
                            ),
                            description: descriptionController.text,
                          );
                    } else {
                      ref.watch(recordProvider.notifier).add(
                            materialId: ref
                                .watch(materialProvider.notifier)
                                .getByTitle(materialController.text),
                            learningTime: int.parse(
                              timerController.text.replaceFirst("分", ""),
                            ),
                            description: descriptionController.text,
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
