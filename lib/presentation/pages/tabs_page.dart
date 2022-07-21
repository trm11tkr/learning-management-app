import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/use_cases/tab_type_provider.dart';
import './record/home_page.dart';
import './my_page/my_page.dart';
import './material/materials_page.dart';

class TabsPage extends ConsumerWidget {
  const TabsPage({Key? key}) : super(key: key);

  final List<Widget> _pages = const [MaterialsPage(), HomePage(), MyPage()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TabType tabType = ref.watch(tabTypeProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
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
      body: SafeArea(child: _pages[tabType.index]),
    );
  }
}
