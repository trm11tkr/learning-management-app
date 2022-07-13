import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:learning_management_app/provider/record_provider.dart';

import '../../model/entities/record.dart';
import '../../provider/material_provider.dart';

class EditRecordPage extends HookConsumerWidget {
  const EditRecordPage({Key? key, this.record}) : super(key: key);

  final Record? record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialData = ref.watch(materialProvider);
    final dropDownValue = useState<String>(record?.materialId ?? '');
    final timerController = useTextEditingController();
    final form = GlobalKey<FormState>();

    useEffect(() {
      if (record != null) {
        timerController.text = record?.learningTime.toString() ?? "";
      }
    }, const []);

    void showPicker() {
      final List<int> timer = [30, 60, 90, 120, 150, 180, 210, 240, 300];
      final pickerItems = timer.map((time) => Text('$time分')).toList();
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
                children: pickerItems,
                onSelectedItemChanged: (int index) {
                  selectedIndex = index;
                },
              ),
            ),
          );
        },
      ).then((_) {
        if (selectedIndex != null) {
          timerController.text = '${timer[selectedIndex]}';
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('記録'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: const Text('教材'),
                      value: dropDownValue.value == ''
                          ? null
                          : dropDownValue.value,
                      items: materialData
                          .map(
                            (material) => DropdownMenuItem(
                              value: material.id,
                              child: Text(material.title),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        dropDownValue.value = value as String;
                      },
                    ),
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
                    decoration: const InputDecoration(
                        label: Text('学習時間'), suffix: Text('分')),
                    onTap: () {
                      // キーボードが出ないようにする
                      FocusScope.of(context).requestFocus(FocusNode());
                      showPicker();
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
                            materialId: dropDownValue.value,
                            learningTime: int.parse(timerController.text),
                          );
                    } else {
                      ref.watch(recordProvider.notifier).add(
                            materialId: dropDownValue.value,
                            learningTime: int.parse(timerController.text),
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
