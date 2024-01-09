import 'package:autoring_app_auth/app/config/routes/routes.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const MyAppbar({
    super.key,
    required this.appBarTitle,
    this.showLeading = false,
  });

  final Text appBarTitle;
  final bool showLeading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(authControllerProvider.notifier);

    return AppBar(
      actions: [
        TextButton(
            onPressed: () {
              authProvider.signOut();
              context.goNamed(MyNamedRoutes.login);
            },
            child: const Text("signOut"))
      ],
      automaticallyImplyLeading: showLeading,
      title: appBarTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
