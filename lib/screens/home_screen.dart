import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/widgets/popular_movie.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Plus"),
        leading: Icon(
          Icons.movie_creation
        ),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          PopularMovie(),
        ],
      ),
    );
  }
}


