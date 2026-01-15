import '../repositories/auth_repository.dart';

class LogoutUsecase {
  const LogoutUsecase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call() => _authRepository.logout();
}




