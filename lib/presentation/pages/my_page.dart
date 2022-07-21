import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/use_cases/my_profile/fetch_my_profile.dart';
import '../widgets/thumbnail.dart';
import './image_viewer/image_viewer.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchMyProfileProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleThumbnail(
                  size: 200,
                  url: profile.value?.image?.url,
                  onTap: () {
                    final url = profile.value?.image?.url;
                    if (url != null) {
                      ImageViewer.show(
                        context,
                        urls: [url],
                        heroTag: 'profile',
                      );
                    }
                  }),
              const SizedBox(height: 20),
              Text(
                profile.value?.name ?? '田中',
                style: const TextStyle(
                    fontSize: 30, overflow: TextOverflow.ellipsis),
              ),
              Text('目標学習時間(分/日)：${profile.value?.targetTime ?? "60"}分',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('学習教材数：${profile.value?.targetTime ?? "0"}',
                  style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
      ),
    );
  }
}
