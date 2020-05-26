import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 500,
      width: 500,
      child: showMovieInCard(response),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 8, 20),
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
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: 'assets/images/avanger.jpg',
                image: "https://image.tmdb.org/t/p/w500/" +
                    response.movies[index].posterPath,
              ),
            ),
          ),
        );
      },
    );
  }
}
