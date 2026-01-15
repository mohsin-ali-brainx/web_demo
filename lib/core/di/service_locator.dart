import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/fake_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<AuthRepository>(() => FakeAuthRepository());
  getIt.registerLazySingleton(() => LoginUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUsecase(getIt<AuthRepository>()));
  getIt.registerFactory(() => AuthBloc(authRepository: getIt<AuthRepository>()));
}


