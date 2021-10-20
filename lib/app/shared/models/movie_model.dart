import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:paysmart_movies/app/shared/models/genre_model.dart';

class Movie {
  final String? name;
  final String? posterPath;
  final List<Genre?>? genres;
  final String? overview;
  final DateTime? releaseDate;
  Movie({
    this.name,
    this.posterPath,
    this.genres,
    this.overview,
    this.releaseDate,
  });

  Movie copyWith({
    String? name,
    String? posterPath,
    List<Genre>? genres,
    String? overview,
    DateTime? releaseDate,
  }) {
    return Movie(
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      name: map['title'],
      posterPath: map['poster_path'],
      genres:
          List<Genre?>.from(map['genre_ids']?.map((x) => Genre?.fromMap(x))),
      overview: map['overview'],
      releaseDate: map["release_date"] != null &&
              map["release_date"].toString().isNotEmpty
          ? DateFormat("yyyy-MM-dd").parse(map["release_date"])
          : null,
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(name: $name, posterPath: $posterPath, genres: $genres, overview: $overview, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.name == name &&
        other.posterPath == posterPath &&
        listEquals(other.genres, genres) &&
        other.overview == overview &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        posterPath.hashCode ^
        genres.hashCode ^
        overview.hashCode ^
        releaseDate.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': name,
      'poster_path': posterPath,
      'genre_ids': genres?.map((x) => x?.toMap()).toList(),
      'overview': overview,
      'release_date': releaseDate == null
          ? null
          : DateFormat("yyyy-MM-dd").format(releaseDate!),
    };
  }

  String toJson() => json.encode(toMap());
}
