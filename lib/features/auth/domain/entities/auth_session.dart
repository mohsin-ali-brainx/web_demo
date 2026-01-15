import 'package:equatable/equatable.dart';

import 'app_role.dart';

class AuthSession extends Equatable {
  const AuthSession({required this.role});

  final AppRole role;

  @override
  List<Object?> get props => [role];
}




