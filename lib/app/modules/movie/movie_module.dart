import 'package:flutter_modular/flutter_modular.dart';
import 'package:paysmart_movies/app/modules/movie/movie_Page.dart';
import 'package:paysmart_movies/app/modules/movie/movie_controller.dart';
import 'package:paysmart_movies/app/shared/models/movie_model.dart';

class MovieModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MovieController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => MoviePage(
              movie: args.data as Movie,
            )),
  ];
}
