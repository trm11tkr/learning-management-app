import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/entities/material.dart';
import '../../provider/material_provider.dart';

class MaterialsPage extends HookConsumerWidget {
  const MaterialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MaterialData>  materialList = ref.watch(materialProvider);
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(materialList[index].title),
            subtitle: Text(materialList[index].createdAt.toString()),
            trailing: Text(materialList[index].category.toString()),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: materialList.length,
      ),
    );
  }
}
