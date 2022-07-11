import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:learning_management_app/provider/record_provider.dart';

import '../pages/edit_material_page.dart';
import '../../provider/material_provider.dart';
import '../../model/entities/material.dart';
import './delete_dialog.dart';

class MaterialItem extends HookConsumerWidget {
  const MaterialItem({Key? key, required this.material}) : super(key: key);

  final MaterialData material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditMaterialPage(
                      material: material,
                    );
                  }));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteDialog(
                        title: material.title,
                        materialId: material.id,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        title: Text(
          material.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('yyyy/MM/dd').format(material.createdAt),
            style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
