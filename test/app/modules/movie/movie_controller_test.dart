import 'package:flutter_test/flutter_test.dart';
import 'package:paysmart_movies/app/modules/movie/movie_controller.dart';
 
void main() {
  late MovieController controller;

  setUpAll(() {
    controller = MovieController();
  });

  test('increment count', () async {
    expect(controller.count, equals(0));
    controller.increment();
    expect(controller.count, equals(1));
  });
}