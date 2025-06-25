import 'package:flutter_application_1/core/constants/app_string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/models/register_request.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/utils/string_utils.dart';

// States
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;
  RegisterSuccess(this.message);
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

class GoogleSignInSuccess extends RegisterState {
  final String email;
  GoogleSignInSuccess(this.email);
}

// Cubit
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;
  final GoogleSignIn googleSignIn;

  RegisterCubit({required this.authRepository, required this.googleSignIn})
    : super(RegisterInitial());

  Future<void> register({
    required String username,
    required String password,
    required String email,
    required String fullName,
  }) async {
    emit(RegisterLoading());

    try {
      final nameParts = StringUtils.splitFullName(fullName);
      final request = RegisterRequest(
        username: username.trim(),
        password: password.trim(),
        email: email.trim(),
        firstName: nameParts['firstName'] ?? '',
        lastName: nameParts['lastName'] ?? '',
      );

      final response = await authRepository.register(request);

      if (response.success) {
        emit(RegisterSuccess(AppStrings.registerSuccess));
      } else {
        emit(RegisterError(response.message ?? AppStrings.registerFailed));
      }
    } catch (e) {
      emit(RegisterError(AppStrings.generalError));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final account = await googleSignIn.signIn();
      if (account != null) {
        emit(GoogleSignInSuccess(account.email));
      }
    } catch (e) {
      emit(RegisterError(AppStrings.googleSignInFailed));
    }
  }

  void signInWithFacebook() {
    // TODO: Implement Facebook sign-in
    print('Facebook register pressed');
  }
}
