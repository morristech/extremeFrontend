import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'kindOfSport.dart';

class PlaylistScreen extends StatelessWidget {
//  final String text;

  // receive data from the FirstScreen as a parameter
  PlaylistScreen({
    Key key,
//    @required this.text
  }) : super(key: key);

  void _searchIconAction() {
    // Search some video function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(47, 44, 71, 1),
        title: Text('Название плейлиста'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(14, 11, 38, 1),
        child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              HeaderPlaylist(),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 5),
                child: Text(
                  'Видео',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              VideoCard(),
              VideoCard(),
              VideoCard(),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Text(
                  'Смотри также',
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              OtherPlaylistList(),
            ],
        ),
      ),
    );
  }
}

class HeaderPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWigth = MediaQuery.of(context).size.width;
    final double cardHeigth = 240;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: screenWigth,
          height: cardHeigth,
          decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage("extreme2.jpg"),
            ),
          ),
        ),
        Positioned(
            width: screenWigth,
            height: cardHeigth,
            top: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color.fromRGBO(14, 11, 38, 1),
                    const Color.fromRGBO(14, 11, 38, 0)
                  ],
                  // whitish to gray
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
            )),
        Positioned(
          bottom: 15,
          child: Container(
            color: Colors.transparent,
            width: screenWigth,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 3),
                  child: Text(
                    "Название плейлиста",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Описание данного плейлиста",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        size: 20,
                        color: Colors.white,
                      ),
                      tooltip: 'Placeholder',
                      onPressed: () {},
                    ),
                    Text(
                      "1555",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.local_movies,
                        size: 20,
                        color: Colors.white,
                      ),
                      tooltip: 'Placeholder',
                      onPressed: () {},
                    ),
                    Text(
                      "89",
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}