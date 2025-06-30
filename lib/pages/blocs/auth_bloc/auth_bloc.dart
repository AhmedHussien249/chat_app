import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
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
    });
    on<RegisterEvent>(
      (event, emit) async {
        emit(RegisterLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(
                errorMessage: 'The password provided is too weak.'));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(
                errorMessage: 'The account already exists for that email.'));
          } else if (ex.code == 'invalid-email') {
            emit(RegisterFailure(
                errorMessage: 'The email address is not valid.'));
          }
        } catch (e) {
          emit(
              RegisterFailure(errorMessage: 'There was an error registering.'));
        }
      },
    );
  }
}
