import 'package:flutter/material.dart';

import '../../model/entities/material.dart';
import '../pages/material_detail_page.dart';

class MaterialItem extends StatelessWidget {
  const MaterialItem({Key? key, required this.material}) : super(key: key);

  final MaterialData material;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MaterialDetailPage(
            data: material,
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
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: material.image == null
                    ? const Icon(
                        Icons.image,
                      )
                    : const Icon(Icons.image),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(material.dateLabel,
                      style: const TextStyle(color: Colors.grey))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
