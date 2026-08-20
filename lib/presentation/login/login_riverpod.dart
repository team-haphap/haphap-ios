import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_riverpod.dart';
import '../../data/remote/datasource/api/auth/auth_data_source.dart';
import '../../data/remote/datasource/impl/auth/auth_data_source_impl.dart';
import '../../data/remote/service/auth_service.dart';
import '../../data/repository/api/auth/auth_repository.dart';
import '../../data/repository/impl/auth/auth_repository_impl.dart';
import 'login_notifier.dart';

export '../../core/network/network_riverpod.dart'
    show localTokenDataSourceProvider, dioProvider;

final _authServiceProvider = Provider(
  (ref) => AuthService(ref.read(dioProvider)),
);

final _authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSourceImpl(ref.read(_authServiceProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(_authDataSourceProvider),
    ref.read(localTokenDataSourceProvider),
  ),
);

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
