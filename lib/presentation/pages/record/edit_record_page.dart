import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../model/use_cases/record_controller.dart';
import '../../../model/use_cases/material_controller.dart';
import '../../../model/entities/record.dart';
import '../material/edit_material_page.dart';
import '../../../extensions/exception_extension.dart';
import '../../widgets/show_indicator.dart';

final _key = GlobalKey<FormState>();

class EditRecordPage extends HookConsumerWidget {
  const EditRecordPage({Key? key, this.data}) : super(key: key);

  final Record? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final materialData = ref.watch(materialDataProvider);
    final timerController = useTextEditingController();
    final materialController = useTextEditingController();
    final descriptionController = useTextEditingController();

    useEffect(() {
      if (data != null) {
        materialController.text = ref
            .watch(materialDataProvider.notifier)
            .getById(data!.materialId)
            .title;
        timerController.text = '${data?.learningTime}分';
        descriptionController.text = data?.description.toString() ?? '';
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
      appBar: AppBar(title: data == null ? const Text('登録') : const Text('編集')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
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
                        '15',
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
                    onPressed: () async {
                      if (_key.currentState?.validate() != true) {
                        return;
                      }

                      _key.currentState?.save();
                      final materialId = ref
                          .watch(materialDataProvider.notifier)
                          .getByTitle(materialController.text)
                          .id;
                      showIndicator(context);
                      if (data != null) {
                        final result = await ref
                            .read(recordProvider.notifier)
                            .update(data!.copyWith(
                                materialId: materialId,
                                learningTime: int.parse(
                                    timerController.text.replaceFirst("分", "")),
                                description: descriptionController.text));
                        result.when(
                          success: () {},
                          failure: (e) {
                            print(e.errorMessage);
                          },
                        );
                      } else {
                        final result =
                            await ref.read(recordProvider.notifier).create(
                                  materialId,
                                  int.parse(
                                    timerController.text.replaceFirst("分", ""),
                                  ),
                                  descriptionController.text,
                                );
                      }
                      dismissIndicator(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text('登録'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
