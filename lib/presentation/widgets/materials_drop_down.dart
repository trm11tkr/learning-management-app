import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../provider/record_provider.dart';
import '../../provider/material_provider.dart';

class MaterialsDropDown extends HookConsumerWidget {
  const MaterialsDropDown({Key? key, this.materialId}) : super(key: key);

  final String? materialId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialData = ref.watch(materialProvider);
    final dropDownValue = useState<String>(materialId ?? 'noData');
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: const Text('教材'),
        value: dropDownValue.value == 'noData' ? null : dropDownValue.value,
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
    );
  }
}
