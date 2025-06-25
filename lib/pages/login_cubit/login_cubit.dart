import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'user-not-found':
          emit(LoginFailure(errorMessage: 'No user found for that email.'));
          break;
        case 'wrong-password':
          emit(LoginFailure(errorMessage: 'Wrong password.'));
          break;
        case 'invalid-credential':
        case 'invalid-login-credentials':
          emit(LoginFailure(errorMessage: 'Invalid email or password.'));
          break;
        default:
          emit(LoginFailure(
              errorMessage: 'An unexpected error occurred: ${ex.message}'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'There was an error logging in.'));
    }
  }
}
