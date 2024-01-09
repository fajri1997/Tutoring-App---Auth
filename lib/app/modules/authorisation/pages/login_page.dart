import 'package:autoring_app_auth/app/config/routes/routes.dart';
import 'package:autoring_app_auth/app/config/theme/my_colors.dart';
import 'package:autoring_app_auth/app/core/extentions/build_conext_extinsion.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/auth_provider.dart';
import 'package:autoring_app_auth/app/modules/authorisation/widgets/my_sign_in.dart';
import 'package:autoring_app_auth/shared/myapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);
    final fieldValues = ref.watch(authFormController);

    return Scaffold(
      appBar: MyAppbar(
        appBarTitle: Text(
          context.translate.register,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthSignInForm(registerFormKey: formKey),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  authProvider.login(
                      email: fieldValues.email,
                      userName: fieldValues.userName,
                      password: fieldValues.password);
                  context.pushNamed(MyNamedRoutes.home);
                }
              },
              child: Text(context.translate.login)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("you dont have an account?"),
              TextButton(
                  onPressed: () {
                    context.goNamed(MyNamedRoutes.register);
                  },
                  child: Text(
                    context.translate.register,
                    style: const TextStyle(color: Colors.lightBlue),
                  ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
              onPressed: () {
                authProvider.signInWithGoogle();
                context.pushNamed(MyNamedRoutes.home);
              },
              child: Text(context.translate.googleLogin)),
        ],
      ),
    );
  }
}
