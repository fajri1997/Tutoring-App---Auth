import 'package:autoring_app_auth/shared/myapp_bar.dart';

import 'package:flutter/material.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppbar(appBarTitle: Text("chatbar")),
    );
  }
}
