import 'package:recetas/presentation/screens/utils/validation_item.dart';

class RegisterState {
  ValidationItem userName;
  ValidationItem email;
  ValidationItem password;
  ValidationItem comfirmPassword;

  RegisterState({
    this.userName = const ValidationItem(),
    this.email = const ValidationItem(),
    this.password = const ValidationItem(),
    this.comfirmPassword = const ValidationItem(),
  });

  RegisterState copiwith(
    ValidationItem? userName,
    ValidationItem? email,
    ValidationItem? password,
    ValidationItem? comfirmPassword,
  ) {
    return RegisterState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      comfirmPassword: comfirmPassword ?? this.comfirmPassword,
    );
  }

  bool isValid() {
    if (userName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        comfirmPassword.value.isEmpty ||
        userName.error.isNotEmpty ||
        email.error.isNotEmpty ||
        password.error.isNotEmpty ||
        comfirmPassword.error.isNotEmpty) {
      return false;
    }
    return true;
  }
}
