import 'package:recetas/presentation/screens/utils/validation_item.dart';

class RegisterState {
  ValidationItem userName;
  ValidationItem email;
  ValidationItem password;
  ValidationItem confirmPassword;

  RegisterState({
    this.userName = const ValidationItem(),
    this.email = const ValidationItem(),
    this.password = const ValidationItem(),
    this.confirmPassword = const ValidationItem(),
  });

  RegisterState copyWith({
    ValidationItem? userName,
    ValidationItem? email,
    ValidationItem? password,
    ValidationItem? confirmPassword,
  }) {
    return RegisterState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  bool isValid() {
    if (userName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty ||
        userName.error.isNotEmpty ||
        email.error.isNotEmpty ||
        password.error.isNotEmpty ||
        confirmPassword.error.isNotEmpty ||
        (password.value != confirmPassword.value)) {
      return false;
    }
    return true;
  }
}
