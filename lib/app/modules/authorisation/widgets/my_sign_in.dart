// ignore_for_file: unused_element

import 'package:autoring_app_auth/app/core/extentions/build_conext_extinsion.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/helper/auth_validator.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/auth_provider.dart';
import 'package:autoring_app_auth/app/modules/authorisation/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAuthSignInForm extends ConsumerStatefulWidget {
  const MyAuthSignInForm({
    super.key,
    this.registerFormKey,
  });

  final GlobalKey<FormState>? registerFormKey;

  @override
  ConsumerState createState() => _MyAuthFormState();
}

class _MyAuthFormState extends ConsumerState<MyAuthSignInForm> {
  final authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authFormContrller = ref.watch(authFormController);

    return SizedBox(
      child: Form(
        key: widget.registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextFormWidget(
                controller: emailController,
                obscureText: false,
                focusNode: emailFocusNode,
                validator: (input) {
                  return authValidators.emailValidator(input);
                },
                prefIcon: const Icon(Icons.email),
                labelText: context.translate.email,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  if (value != null) {
                    authFormContrller.setEmailField(value);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 12,
              ),
              MyTextFormWidget(
                controller: passwordController,
                obscureText:
                    authFormContrller.togglePassword == false ? true : false,
                focusNode: passwordFocusNode,
                validator: (input) => authValidators.passwordVlidator(input),
                prefIcon: const Icon(Icons.password),
                labelText: context.translate.password,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  if (value != null) {
                    authFormContrller.setPasswordField(value);
                  }
                  return null;
                },
                togglePassword: () {
                  authFormContrller.togglePasswordIcon();
                },
                suffexIcon: Icon(
                  authFormContrller.togglePassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
