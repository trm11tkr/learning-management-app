import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/entities/material.dart';
import '../../provider/material_provider.dart';
import '../widgets/material_item.dart';
import './edit_material_page.dart';

class MaterialsPage extends HookConsumerWidget {
  const MaterialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MaterialData> materialList = ref.watch(materialProvider);
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
            return EditMaterialPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
