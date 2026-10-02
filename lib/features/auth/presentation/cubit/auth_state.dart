abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}

class RegisterSuccess extends AuthState {
  final String message;

  const RegisterSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
