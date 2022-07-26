import 'dart:async';

import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './edit_my_page.dart';
import '../login_page.dart';
import '../../../model/use_cases/my_profile/fetch_my_profile.dart';
import '../../widgets/thumbnail.dart';
import '../image_viewer/image_viewer.dart';
import '../../../model/use_cases/auth/sign_out.dart';
import '../../../extensions/int_extension.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchMyProfileProvider).value;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleThumbnail(
                    size: 200,
                    url: profile?.image?.url,
                    onTap: () {
                      final url = profile?.image?.url;
                      if (url != null) {
                        ImageViewer.show(
                          context,
                          urls: [url],
                          heroTag: 'profile',
                        );
                      }
                    }),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const EditMyPage();
                      }));
                    },
                    child: const Text('編集')),
                const SizedBox(height: 20),
                Text(
                  profile?.name ?? '-',
                  style: const TextStyle(
                      fontSize: 30, overflow: TextOverflow.ellipsis),
                ),
                Text(
                    '目標学習時間(分/日)：${profile?.targetTime?.toHMString() ?? "60分"}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('学習教材数：${profile?.numOfMaterials ?? "0"}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    final result = await showOkCancelAlertDialog(
                      context: context,
                      title: 'ログアウト',
                      message: 'ログアウトしますか？',
                    );
                    if (result == OkCancelResult.ok) {
                      await ref.read(signOutProvider)();
                      unawaited(
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        })),
                      );
                    }
                  },
                  child: Text(
                    'サインアウト',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
