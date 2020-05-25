import 'package:dio/dio.dart';
import 'package:movieapp/module/movie_list_response.dart';
import 'package:movieapp/module/movie_response.dart';

class MovieRepository {
  final String apiKey = "20082cd96a63caa22aa1535434c85397";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getMovieByID = '$mainUrl/movie';
  var getPopularUrl = '$mainUrl/movie/popular';

  Future<MovieResponse> getMovies(int movieId) async {
    var params = {"api_key": apiKey, "language": "en-US", "movie_id": movieId};
    try {
      Response response = await _dio.get(getMovieByID, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieListResponse> getPopularMovie(int pageNumber) async {
    print("page number" + pageNumber.toString() + ":");
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      print(">>>>>>>>>>>>: $response");
      return MovieListResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception oh: $error stackTrace: $stacktrace");
      return MovieListResponse.withError("$error");
    }
  }
}
