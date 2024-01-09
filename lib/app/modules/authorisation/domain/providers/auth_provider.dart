import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/controllers/form_controller.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/repo/auth_repo.dart';
import 'package:autoring_app_auth/app/modules/authorisation/widgets/my_auth_form.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/controllers/auth_controller.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/controllers/form_controller.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/repo/auth_repo.dart';
import 'package:autoring_app_auth/app/modules/authorisation/domain/providers/state/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  ref.read(authControllerProvider);
  return authRepository.authStateChanges;
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      AuthState(),
      ref.watch(authRepositoryProvider),
    );
  },
);

final authFormController =
    ChangeNotifierProvider((ref) => MyAuthFormController());

final checkIfAuthinticated =
    FutureProvider((ref) => ref.watch(authStateProvider));
