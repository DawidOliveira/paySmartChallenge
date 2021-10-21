import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:paysmart_movies/app/modules/movie/movie_controller.dart';
import 'package:paysmart_movies/app/shared/models/movie_model.dart';
import 'package:paysmart_movies/app/shared/widgets/tag_genre.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage({required this.movie});
  @override
  MoviePageState createState() => MoviePageState();
}

class MoviePageState extends State<MoviePage> {
  final MovieController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Detalhes do filme",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: size.height * .55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: widget.movie.hashCode,
                      child: Builder(builder: (context) {
                        if (widget.movie.posterPath != null) {
                          return CachedNetworkImage(
                            imageUrl: widget.movie.posterPath!,
                            fit: BoxFit.fitWidth,
                          );
                        }
                        return const Icon(Icons.movie);
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.movie.name!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                Text(
                  "Lançamento: ${widget.movie.releaseDate != null ? DateFormat("dd/MM/yyyy").format(widget.movie.releaseDate!) : 'sem data'}",
                ),
                if (widget.movie.genres != null ||
                    widget.movie.genres!.isNotEmpty)
                  const SizedBox(height: 10),
                if (widget.movie.genres != null ||
                    widget.movie.genres!.isNotEmpty)
                  Wrap(
                    children: widget.movie.genres!
                        .map((e) => TagGenre(
                              label: e!.name!,
                            ))
                        .toList(),
                  ),
                const SizedBox(height: 10),
                Text(
                  "Visão geral",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 10),
                Text(widget.movie.overview!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
