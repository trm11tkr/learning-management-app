import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

import '../../../model/entities/material.dart';
import '../../widgets/material_item.dart';
import 'edit_material_page.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../../extensions/exception_extension.dart';
import '../../../model/use_cases/material/material_controller.dart';

class MaterialsPage extends HookConsumerWidget {
  const MaterialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MaterialData> materialList = ref.watch(materialDataProvider);

    /// カスタムフック
    useEffectOnce(() {
      Future(() async {
        final result = await ref.read(materialDataProvider.notifier).fetch();
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MaterialItem(material: materialList[index]);
        },
        itemCount: materialList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const EditMaterialPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
