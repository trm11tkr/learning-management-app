import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../provider/record_provider.dart';
import '../pages/edit_material_page.dart';
import '../../provider/material_provider.dart';
import '../../model/entities/material.dart';
import './delete_dialog.dart';
import '../pages/material_detail_page.dart';

class MaterialItem extends HookConsumerWidget {
  const MaterialItem({Key? key, required this.material}) : super(key: key);

  final MaterialData material;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MaterialDetailPage(
            id: material.id,
            title: material.title,
            createdAt: material.createdAt,
            imageUrl: material.imageUrl,
          );
        }));
      },
      child: Card(
        elevation: 3.0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Container(
          height: 140,
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(10),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: material.imageUrl == null
                    ? const Icon(
                        Icons.image,
                      )
                    : const Icon(Icons.image),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 110,
              right: 80,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(DateFormat('yyyy/MM/dd').format(material.createdAt),
                        style: const TextStyle(color: Colors.grey))
                  ],
                ),
              ),
            ),
            Positioned(
              right: 50,
              child: IconButton(
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
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteDialog(
                        title: '「${material.title}」を削除してよろしいですか？',
                        content: '${material.title}による学習記録は全て削除されます。',
                        deleteHandle: () {
                          ref
                              .watch(materialProvider.notifier)
                              .remove(material.id);
                          ref
                              .watch(recordProvider.notifier)
                              .removeByMaterialId(material.id);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
