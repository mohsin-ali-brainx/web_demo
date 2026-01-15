import 'dart:async';

import '../../domain/entities/app_role.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository() {
    _controller = StreamController<AuthSession?>.broadcast();
  }

  late final StreamController<AuthSession?> _controller;
  AuthSession? _session;

  @override
  AuthSession? get currentSession => _session;

  @override
  Stream<AuthSession?> get sessionChanges => _controller.stream;

  @override
  Future<void> login({required AppRole role}) async {
    _session = AuthSession(role: role);
    _controller.add(_session);
  }

  @override
  Future<void> logout() async {
    _session = null;
    _controller.add(_session);
  }
}




