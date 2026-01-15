import '../entities/app_role.dart';
import '../entities/auth_session.dart';

abstract class AuthRepository {
  Stream<AuthSession?> get sessionChanges;
  AuthSession? get currentSession;

  Future<void> login({required AppRole role});
  Future<void> logout();
}




