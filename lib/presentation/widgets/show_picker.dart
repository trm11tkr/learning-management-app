import 'package:flutter/material.dart';

import 'package:flutter_picker/flutter_picker.dart';

Future<String?> showMapItemPicker({
  required BuildContext context,
  required List<Map> items,
  String? title,
  Widget? pickerDelimiter,
  String Function(int)? onFormatValue,
  void Function(Picker, List<int>)? onConfirm,
  TextStyle? selectedStyle,
}) async {
  int? selectedIndex;
  await Picker(
          adapter: PickerDataAdapter<String>(
            pickerdata: items.map((e) => e['display']).toList(),
          ),
          hideHeader: true,
          title: Text(title ?? 'セットしてください。'),
          confirmText: "決定",
          cancelText: "キャンセル",
          onConfirm: onConfirm ??
              (Picker picker, List<int> value) {
                selectedIndex = value.first;
              })
      .showDialog(context);
  if (selectedIndex != null) {
    return items[selectedIndex!]['value'];
  }
  return null;
}

Future<int?> showPickerNumberFormatValue({
  required BuildContext context,
  String? title,
  int? firstBegin,
  int? firstEnd,
  int? secondBegin,
  int? secondEnd,
  Widget? pickerDelimiter,
  String Function(int)? onFormatValue,
  void Function(Picker, List<int>)? onConfirm,
  TextStyle? selectedStyle,
}) async {
  int? selectedTime;
  await Picker(
          adapter: NumberPickerAdapter(data: [
            NumberPickerColumn(
                begin: firstBegin ?? 0,
                end: firstEnd ?? 23,
                onFormatValue: onFormatValue ??
                    (v) {
                      return v < 10 ? "0$v" : "$v";
                    }),
            NumberPickerColumn(begin: secondBegin ?? 00, end: secondEnd ?? 59),
          ]),
          delimiter: [
            PickerDelimiter(
              child: Container(
                width: 30.0,
                alignment: Alignment.center,
                child: pickerDelimiter ?? const Text(":"),
              ),
            ),
          ],
          hideHeader: true,
          title: Text(title ?? 'セットしてください。'),
          confirmText: "決定",
          cancelText: "キャンセル",
          selectedTextStyle: selectedStyle,
          onConfirm: onConfirm ??
              (Picker picker, List<int> value) {
                selectedTime = value[0] * 60 + value[1];
              })
      .showDialog(context);
  return selectedTime;
}
