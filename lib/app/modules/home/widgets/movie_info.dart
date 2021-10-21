import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paysmart_movies/app/shared/models/movie_model.dart';
import 'package:paysmart_movies/app/shared/widgets/tag_genre.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                movie.name!,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: movie.genres!
                    .map(
                      (e) => TagGenre(
                        label: e!.name!,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Text(
              movie.releaseDate != null
                  ? DateFormat("dd/MM/yyyy").format(movie.releaseDate!)
                  : "Sem data",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
