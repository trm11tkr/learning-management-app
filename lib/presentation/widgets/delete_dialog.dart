import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.deleteHandle})
      : super(key: key);

  final String title;
  final String content;
  final VoidCallback deleteHandle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            onPressed: deleteHandle,
            child: Text(
              '削除',
              style: TextStyle(color: Theme.of(context).errorColor),
            )),
      ],
    );
  }
}
