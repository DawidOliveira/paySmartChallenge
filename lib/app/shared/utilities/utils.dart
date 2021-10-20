import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paysmart_movies/app/core/constants.dart';

class Utils {
  Utils._();

  static Dio client() {
    return Dio(BaseOptions(
      baseUrl: Constants.apiUrl,
      queryParameters: {
        "api_key": dotenv.env["API_KEY"],
        "sort_by": "original_title.asc",
      },
    ));
  }
}
