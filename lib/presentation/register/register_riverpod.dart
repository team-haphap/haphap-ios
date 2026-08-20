import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_riverpod.dart';
import '../../data/remote/datasource/api/register/register_data_source.dart';
import '../../data/remote/datasource/impl/register/register_data_source_impl.dart';
import '../../data/remote/service/register_service.dart';
import '../../data/repository/api/register/register_repository.dart';
import '../../data/repository/impl/register/register_repository_impl.dart';
import 'register_notifier.dart';

final _registerServiceProvider = Provider(
  (ref) => RegisterService(ref.read(dioProvider)),
);

final _registerDataSourceProvider = Provider<RegisterDataSource>(
  (ref) => RegisterDataSourceImpl(ref.read(_registerServiceProvider)),
);

final registerRepositoryProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepositoryImpl(ref.read(_registerDataSourceProvider)),
);

final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);
