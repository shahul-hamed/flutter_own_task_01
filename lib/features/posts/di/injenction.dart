// lib/injection.dart

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:own_task_01/features/posts/data/datasources/post_local_data_source.dart';
import 'package:own_task_01/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:own_task_01/features/posts/data/repositories/post_repository.dart';
import 'package:own_task_01/features/posts/domain/usecases/posts_usecase.dart';
import 'package:own_task_01/features/posts/presentation/view_models/post_view_model.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register dependencies
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<PostRemoteDataSource>(
        () => PostRemoteDataSourceImpl(client: getIt()),);
  getIt.registerLazySingleton<PostLocalDataSource>(
        () => PostLocalDataSource(),);
  getIt.registerLazySingleton<PostRepository>(
        () => PostRepositoryImpl(remoteDataSource: getIt(),localDataSource: getIt()),
  );
  getIt.registerLazySingleton<PostUseCase>(
        () => PostUseCase(repository: getIt()),
  );
  // getIt.registerLazySingleton<PostViewModel>(
  //       () => PostViewModel(useCase: getIt()),
  // );
}
