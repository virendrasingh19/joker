import 'package:movieapp/Repository/repository.dart';
import 'package:movieapp/module/movie_list_response.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieListResponse> _subject =
      BehaviorSubject<MovieListResponse>();

      getMovies(int pageNumber) async {
    MovieListResponse response = await _repository.getPopularMovie(pageNumber);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieListResponse> get subject => _subject;
}

final moviesBloc = MoviesBloc();
