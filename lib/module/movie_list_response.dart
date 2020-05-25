import 'MovieList.dart';
import 'movie.dart';

class MovieListResponse {
  final List<Results> movies;
  final String error;

  MovieListResponse(this.movies, this.error);

  MovieListResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((i) => new Results.fromJson(i))
            .toList(),
        error = "";

  MovieListResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}
