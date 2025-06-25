import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(
            errorMessage: 'The password provided is too weak.'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errorMessage: 'The account already exists for that email.'));
      } else if (ex.code == 'invalid-email') {
        emit(RegisterFailure(errorMessage: 'The email address is not valid.'));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'There was an error registering.'));
    }
  }
}
