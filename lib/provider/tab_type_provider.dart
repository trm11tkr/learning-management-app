import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TabType {
  home,
  learningRecord,
  materials,
}

final tabTypeProvider = StateProvider((_) => TabType.home);
