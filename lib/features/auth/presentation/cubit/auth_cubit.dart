import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/auth/data/repo/auth_repo.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo = AuthRepo();

  AuthCubit() : super(const AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());

    try {
      await authRepo.login(email: email, password: password);

      emit(const LoginSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    String? image,
  }) async {
    emit(const AuthLoading());

    try {
      final response = await authRepo.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
        image: image,
      );

      emit(RegisterSuccess(response.message));
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
