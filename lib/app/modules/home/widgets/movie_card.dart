import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paysmart_movies/app/modules/home/widgets/movie_info.dart';
import 'package:paysmart_movies/app/shared/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(4),
      elevation: 1,
      shadowColor: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          Navigator.of(context).pushNamed(
            "/movie/",
            arguments: movie,
          );
        },
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            children: [
              movie.posterPath != null && movie.posterPath!.isNotEmpty
                  ? SizedBox(
                      width: 130,
                      height: 200,
                      child: Hero(
                        tag: movie.name!,
                        child: CachedNetworkImage(
                          imageUrl: movie.posterPath!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 150,
                      height: 200,
                      child: Icon(
                        Icons.movie_creation_outlined,
                      ),
                    ),
              Expanded(
                child: MovieInfo(movie: movie),
              )
            ],
          ),
        ),
      ),
    );
  }
}
