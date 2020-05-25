import 'movie.dart';

class MovieResponse {
  final Movie movie;
  final String error;

  MovieResponse(this.movie, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movie = json['movie'],
        error = "";

  MovieResponse.withError(String errorValue)
      : movie = Movie(),
        error = errorValue;
}
