import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:paysmart_movies/app/repositories/movies_repository/movies_repository.dart';
import 'package:paysmart_movies/app/shared/models/movie_model.dart';
import 'package:paysmart_movies/app/shared/utilities/controller_notifier.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeController extends ControllerNotifier {
  final MoviesRepository _moviesRepository;
  final Connectivity _connectivity;
  final _movies = RxNotifier<List<Movie>>([]);
  final _page = RxNotifier<int>(1);

  final scrollController = ScrollController();
  final search = TextEditingController();

  HomeController(this._moviesRepository, this._connectivity) {
    loading = true;
    loadDeps().whenComplete(() => loading = false);
    scrollController.addListener(() async {
      if (await _connectivity.checkConnectivity() != ConnectionState.none) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          loadList = true;
          page += 1;
          movies.addAll(await _moviesRepository.fetchMovies(page: page));
          _movies.notifyListeners();
          loadList = false;
        }
      }
    });
  }

  Future<void> onChanged(String value) async {
    loading = true;
    if (value == "") {
      page = 1;
      movies = await _moviesRepository.fetchMovies(page: page);
    } else {
      movies = await _moviesRepository.findMovies(text: value);
    }
    loading = false;
  }

  List<Movie> get movies => _movies.value;
  set movies(List<Movie> value) => _movies.value = value;

  int get page => _page.value;
  set page(int value) => _page.value = value;

  Future<void> loadDeps() async {
    movies = await _moviesRepository.fetchMovies(page: page);
  }
}
