import 'package:api/models/user_repositories.dart';
import 'package:get_it/get_it.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<UserRepositories>(UserRepositories());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
