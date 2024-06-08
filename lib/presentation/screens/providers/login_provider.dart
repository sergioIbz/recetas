import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recetas/presentation/screens/utils/validation_item.dart';

import '../auth/login/login_state.dart';

final loginStateProvider =
    StateNotifierProvider<LoginStateNotifierProvider, LoginState>((ref) {
  return LoginStateNotifierProvider();
});

class LoginStateNotifierProvider extends StateNotifier<LoginState> {
  //
  LoginStateNotifierProvider()
      : super(
          LoginState(),
        );

  void changeEmail(String value) {
    final bool emailFormatValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailFormatValid) {
      state = state.copyWith(
        email: const ValidationItem(
          error: 'No es un email',
        ),
      );
    } else if (value.length >= 6) {
      state = state.copyWith(
        email: ValidationItem(
          value: value,
          error: '',
        ),
      );
    } else {
      state = state.copyWith(
        email: const ValidationItem(
          error: 'Al menos 6 caracteres',
        ),
      );
    }
  }

  void changePassword(String value) {
    if (value.length >= 6) {
      state = state.copyWith(
        password: ValidationItem(
          value: value,
          error: '',
        ),
      );
    } else {
      state = state.copyWith(
        password: const ValidationItem(
          error: 'Al menos 6 caracteres',
        ),
      );
    }
  }

  bool isValid() => state.isValid();
}
