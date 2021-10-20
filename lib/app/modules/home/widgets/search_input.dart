import 'package:flutter/material.dart';
import 'package:paysmart_movies/app/modules/home/home_controller.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    required this.store,
  });

  final HomeController store;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
