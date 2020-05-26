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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Text("Movie Plus",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans',
                fontSize: 26)),
        leading: Icon(
          Icons.movie_creation,
          color: Colors.black,
          size: 36,
        ),
        actions: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black,
            size: 36,
          )
        ],
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
