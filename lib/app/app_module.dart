import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:paysmart_movies/app/modules/movie/movie_module.dart';
import 'package:paysmart_movies/app/repositories/movies_repository/movies_repository.dart';
import 'package:paysmart_movies/app/shared/utilities/utils.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Connectivity()),
    Bind.lazySingleton((i) => Utils.client()),
    Bind.lazySingleton((i) => MoviesRepository(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute("/movie", module: MovieModule()),
  ];
}
