import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/tab_type_provider.dart';
import './home_page.dart';
import './my_page.dart';
import './materials_page.dart';

class TabsPage extends ConsumerWidget {
  const TabsPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _pages = const [
    {'page': MaterialsPage(), 'title': '教材ページ'},
    {'page': HomePage(), 'title': 'ホーム'},
    {'page': MyPage(), 'title': 'マイページ'}
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TabType tabType = ref.watch(tabTypeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[tabType.index]['title']),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '教材',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'マイページ',
          ),
        ],
        onTap: (int selectIndex) {
          ref.watch(tabTypeProvider.state).state = TabType.values[selectIndex];
        },
        currentIndex: tabType.index,
      ),
      body: _pages[tabType.index]['page'],
    );
  }
}
