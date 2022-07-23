import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../utils/logger.dart';
import '../custom_hooks/use_form_field_state_key.dart';
import '../widgets/show_indicator.dart';
import '../widgets/rounded_button.dart';
import '../../extensions/context_extension.dart';
import '../../model/use_cases/auth/email/sign_in_with_email_and_password.dart';
import '../../model/use_cases/auth/email/create_user_with_email_and_password.dart';
import '../../utils/provider.dart';
import '../pages/tabs_page.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.read(authStateProvider);

    /// カスタムフック
    final mailFormKey = useFormFieldStateKey();
    final passwordFormKey = useFormFieldStateKey();
    final passwordConfirmFormKey = useFormFieldStateKey();
    final isNewAccount = useState<bool>(false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
                hintText: '◯◯@example.com',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              key: mailFormKey,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'メールアドレスが正しくありません'
                  : null,
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'パスワード',
                hintText: 'パスワード',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(),
                isDense: true,
                counterText: '',
              ),
              key: passwordFormKey,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'パスワードを入力してください'
                  : null,
              maxLength: 32,
            ),
            const SizedBox(height: 30),
            isNewAccount.value == true
                ? TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: '確認用パスワード',
                      hintText: '確認用パスワード',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(),
                      isDense: true,
                      counterText: '',
                    ),
                    key: passwordConfirmFormKey,
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'パスワードを入力してください'
                            : null,
                    maxLength: 32,
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: isNewAccount.value == true
                  ? RoundedButton(
                      elevation: 2,
                      onTap: () async {
                        context.hideKeyboard();
                        if (!mailFormKey.currentState!.validate()) {
                          return;
                        }
                        final email =
                            mailFormKey.currentState?.value?.trim() ?? '';
                        final password =
                            passwordFormKey.currentState?.value?.trim() ?? '';
                        try {
                          showIndicator(context);
                          await ref
                              .read(createUserWithEmailAndPasswordProvider)
                              .call(email, password);
                          dismissIndicator(context);
                          context.showSnackBar('ログインしました。');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const TabsPage();
                          }));
                        } on Exception catch (e) {
                          logger.shout(e);
                          dismissIndicator(context);
                          context.showSnackBar(e.toString());
                        }
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          '登録',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  : RoundedButton(
                      elevation: 2,
                      onTap: () async {
                        context.hideKeyboard();
                        if (!mailFormKey.currentState!.validate()) {
                          return;
                        }
                        final email =
                            mailFormKey.currentState?.value?.trim() ?? '';
                        final password =
                            passwordFormKey.currentState?.value?.trim() ?? '';
                        try {
                          showIndicator(context);
                          await ref
                              .read(signInWithEmailAndPasswordProvider)
                              .call(email, password);
                          dismissIndicator(context);
                          context.showSnackBar('ログインしました。');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const TabsPage();
                          }));
                        } on Exception catch (e) {
                          dismissIndicator(context);
                          context.showSnackBar(e.toString());
                        }
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          'サインイン',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
            ),
            isNewAccount.value == true
                ? TextButton(
                    onPressed: () {
                      isNewAccount.value = false;
                    },
                    child: Text(
                      'サインインに戻る',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      isNewAccount.value = true;
                    },
                    child: Text(
                      'アカウントが未登録の場合',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
