import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:paysmart_movies/app/modules/home/home_controller.dart';
import 'package:paysmart_movies/app/modules/home/widgets/movie_card.dart';
import 'package:paysmart_movies/app/modules/home/widgets/search_input.dart';
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
              SearchInput(store: store),
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
                      return MovieCard(movie: movie);
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
