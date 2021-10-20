import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:paysmart_movies/app/modules/home/home_controller.dart';
import 'package:paysmart_movies/app/shared/widgets/tag_genre.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Todos os filmes",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const Text(
                "Aqui serão exibidos todos os filmes. É possível visualizar a lista abaixo, procurar por um em específico e visualizar as informações de um filme.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: store.search,
                onSubmitted: store.onChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: "Procure por um filme...",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[400],
                  ),
                  prefixIcon: const Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: RxBuilder(builder: (context) {
                  if (store.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    controller: store.scrollController,
                    itemBuilder: (context, index) {
                      final movie = store.movies[index];
                      return Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        elevation: 1,
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
                                movie.posterPath != null &&
                                        movie.posterPath!.isNotEmpty
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
                                  child: Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              movie.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
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
                                            DateFormat("dd/MM/yyyy")
                                                .format(movie.releaseDate!),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: store.movies.length,
                  );
                }),
              ),
              const SizedBox(height: 15),
              RxBuilder(builder: (context) {
                return Visibility(
                  visible: store.loadList,
                  child: SizedBox(
                    height: 60,
                    width: size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
