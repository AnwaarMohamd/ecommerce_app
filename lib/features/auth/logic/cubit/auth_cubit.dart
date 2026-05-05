import 'package:ecommerce_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await authRepo.login(email: email, password: password);

      emit(AuthSuccess(user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login failed"));
    } catch (e) {
      emit(AuthError("Something went wrong"));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await authRepo.register(email: email, password: password);

      emit(AuthSuccess(user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Register failed"));
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    emit(AuthInitial());
  }
}
