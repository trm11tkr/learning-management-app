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
    print(profile.asData);
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
                profile.value?.name ?? '-',
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
