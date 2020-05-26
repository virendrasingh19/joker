import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_movies.dart';
import 'package:movieapp/module/MovieList.dart';
import 'package:movieapp/module/movie_list_response.dart';

class PopularMovie extends StatefulWidget {
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  int pageNumber = 1;
  MovieList movies = MovieList();

  @override
  void initState() {
    super.initState();
    moviesBloc..getMovies(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        header(),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieListResponse>(
          stream: moviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieListResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return _buildHomeWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(MovieListResponse response) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 10.0),
      child: showMovieInCard(response),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text("Popular Movie",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans',
                fontSize: 26)),
      ),
    );
  }

  Widget showMovieInCard(MovieListResponse response) {
    return ListView.builder(
      itemCount: response.movies.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Text(
            response.movies[index].title,
          ),
        );
      },
    );
  }
}
