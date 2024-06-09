import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recetas/presentation/screens/auth/register/register_state.dart';

import 'package:recetas/presentation/screens/utils/validation_item.dart';

final registerStateProvider =
    StateNotifierProvider.autoDispose<RegisterNotifierProvider, RegisterState>((ref) {
  return RegisterNotifierProvider();
});

class RegisterNotifierProvider extends StateNotifier<RegisterState> {
  //
  RegisterNotifierProvider()
      : super(
          RegisterState(),
        );

  void changeUserName(String value) {
    if (value.length >= 3) {
      state = state.copyWith(
        userName: ValidationItem(
          value: value,
          error: '',
        ),
      );
    } else {
      state = state.copyWith(
        userName: const ValidationItem(
          error: 'Al menos 3 caracteres',
        ),
      );
    }
  }

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

  void changeConfirmPassword(String value) {
    if (value == state.password.value) {
      state = state.copyWith(
        confirmPassword: ValidationItem(
          value: value,
          error: '',
        ),
      );
    } else {
      state = state.copyWith(
        confirmPassword: const ValidationItem(
          error: 'Las contraseñas no coinciden',
        ),
      );
    }
  }

  bool isValid() => state.isValid();
}
