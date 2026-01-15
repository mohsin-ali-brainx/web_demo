import '../entities/app_role.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  const LoginUsecase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call({required AppRole role}) => _authRepository.login(role: role);
}




