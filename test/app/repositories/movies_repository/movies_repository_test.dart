import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paysmart_movies/app/repositories/movies_repository/movies_repository.dart';
import 'package:paysmart_movies/app/shared/models/genre_model.dart';
import 'package:paysmart_movies/app/shared/utilities/utils.dart';

class ConnectivityMock extends Mock implements Connectivity {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  late ConnectivityMock connectivity;
  late Dio dio;
  late DioAdapter dioAdapter;
  late MoviesRepository movieRepository;

  setUp(() {
    connectivity = ConnectivityMock();
    dio = Utils.client();
    dioAdapter = DioAdapter(dio: dio);
    movieRepository = MoviesRepository(connectivity, dio);
  });

  test("receber uma lista de generos", () async {
    dioAdapter.onGet("/genre/movie/list", (server) {
      server.reply(200, jsonResult);
    });

    final list = await movieRepository.fetchGenres();

    expect(list,
        equals(jsonResult["genres"]!.map((e) => Genre.fromMap(e)).toList()));
  });
}

const jsonResult = {
  "genres": [
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 14, "name": "Fantasy"},
    {"id": 36, "name": "History"},
    {"id": 27, "name": "Horror"},
    {"id": 10402, "name": "Music"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10749, "name": "Romance"},
    {"id": 878, "name": "Science Fiction"},
    {"id": 10770, "name": "TV Movie"},
    {"id": 53, "name": "Thriller"},
    {"id": 10752, "name": "War"},
    {"id": 37, "name": "Western"}
  ]
};
