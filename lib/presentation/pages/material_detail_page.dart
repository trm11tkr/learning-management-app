import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class MaterialDetailPage extends StatelessWidget {
  const MaterialDetailPage({
    Key? key,
    required this.id,
    required this.title,
    required this.createdAt,
    this.imageUrl,
  }) : super(key: key);

  final String id;
  final String title;
  final DateTime createdAt;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          softWrap: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              Container(
                height: mediaQuery.size.height * 0.3,
                width: mediaQuery.size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: imageUrl == null
                    ? const Icon(Icons.image)
                    : const Icon(Icons.image),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Text('登録日：${DateFormat("yyyy/MM/dd").format(createdAt)}'),
            ],
          ),
        ),
      ),
    );
  }
}
