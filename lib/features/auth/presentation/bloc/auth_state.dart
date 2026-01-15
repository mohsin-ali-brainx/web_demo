part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    required this.session,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown, session: null);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated, session: null);

  const AuthState.authenticated(AuthSession session)
      : this._(status: AuthStatus.authenticated, session: session);

  final AuthStatus status;
  final AuthSession? session;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isAdmin => session?.role == AppRole.admin;

  static AuthState fromSession(AuthSession? session) {
    if (session == null) return const AuthState.unauthenticated();
    return AuthState.authenticated(session);
  }

  @override
  List<Object?> get props => [status, session];
}

enum AuthStatus { unknown, unauthenticated, authenticated }




