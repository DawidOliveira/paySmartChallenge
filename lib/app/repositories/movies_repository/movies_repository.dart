import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:paysmart_movies/app/core/constants.dart';
import 'package:paysmart_movies/app/repositories/local_storage/local_storage.dart';
import 'package:paysmart_movies/app/shared/models/genre_model.dart';
import 'package:paysmart_movies/app/shared/models/movie_model.dart';
import 'package:paysmart_movies/app/shared/utilities/utils.dart';

class MoviesRepository {
  final Connectivity _connectivity;
  final Dio _dio;

  MoviesRepository(this._connectivity, this._dio);

  Future<List<Movie>> fetchMovies({required int page}) async {
    if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
      if (await LocalStorage.getListData("movies") != null) {
        return LocalStorage.getListData("movies").then((value) {
          return value!.map((e) => Movie.fromJson(e)).toList();
        });
      } else {
        return [];
      }
    }
    return _dio.get("/movie/upcoming?page=$page").then((value) async {
      final data = await jsonToListMovie(value);

      await LocalStorage.saveListData("movies",
          data: data.map((e) => e.toJson()).toList());

      return data;
    });
  }

  Future<List<Movie>> jsonToListMovie(Response<dynamic> value) async {
    final genres = await fetchGenres();

    return (value.data["results"] as List).map((e) {
      final movie = e;
      if (movie["genre_ids"] != null) {
        movie["genre_ids"] = (movie["genre_ids"] as List).map((e) {
          for (final genre in genres) {
            if (genre.id == e) {
              return genre.toMap();
            }
          }
        }).toList();
      }
      if (movie["poster_path"] != null) {
        movie["poster_path"] = Constants.imgUrl + movie["poster_path"];
      }
      return Movie.fromMap(e);
    }).toList();
  }

  Future<List<Movie>> findMovies({required String text}) async {
    if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
      if (await LocalStorage.getListData("movies") != null) {
        return LocalStorage.getListData("movies").then((value) {
          return value!
              .map((e) => Movie.fromJson(e))
              .toList()
              .where((element) =>
                  element.name!.toLowerCase().contains(text.toLowerCase()))
              .toList();
        });
      } else {
        return [];
      }
    }
    return _dio.get("/search/movie?page=1&query=$text").then((value) async {
      if (value.data["results"] == null ||
          (value.data["results"] as List).isEmpty) {
        return [];
      }
      return await jsonToListMovie(value);
    });
  }

  Future<List<Genre>> fetchGenres() async {
    return Utils.client().get("/genre/movie/list").then((value) {
      return (value.data["genres"] as List)
          .map((e) => Genre.fromMap(e))
          .toList();
    });
  }
}
