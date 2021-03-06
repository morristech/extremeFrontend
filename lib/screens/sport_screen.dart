import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/movie_card.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/stats.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';

/// Создаёт экран вида спорта
class SportScreen extends StatelessWidget {
  const SportScreen({Key key}) : super(key: key);

  void _searchIconAction() {
    //TODO: Search some video function
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text('Вид спорта'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      builder: (context) => <Widget>[
        Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage("assets/images/extreme2.jpg"),
            )),
            child: Container(
              padding: EdgeInsets.all(Indents.md),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0,
                    0.8,
                    1
                  ],
                      colors: [
                    theme.colorScheme.background.withOpacity(0),
                    theme.colorScheme.background.withOpacity(1),
                    theme.colorScheme.background.withOpacity(1),
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Вид спорта',
                    style: theme.textTheme.headline5.merge(TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 0.25)),
                  ),
                  Text('Этот вид спорта просто крут. Вот так! Описание...',
                      style: Theme.of(context).textTheme.bodyText2),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Indents.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stats(icon: Icons.thumb_up, text: '1548'),
                        Stats(icon: Icons.local_movies, text: '89'),
                        Stats(icon: Icons.playlist_play, text: '1548'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          onPressed: () {},
                          color: theme.colorScheme.onSurface,
                          child: Text('ВИДЕО',
                              style: theme.textTheme.button.merge(TextStyle(
                                  color: theme.colorScheme.surface)))),
                      RaisedButton(
                          onPressed: () {},
                          color: theme.colorScheme.onSurface,
                          child: Text('ПЛЕЙЛИСТЫ',
                              style: theme.textTheme.button.merge(TextStyle(
                                  color: theme.colorScheme.surface)))),
                      RaisedButton(
                          onPressed: () {},
                          color: theme.colorScheme.onSurface,
                          child: Text('ФИЛЬМЫ',
                              style: theme.textTheme.button.merge(TextStyle(
                                  color: theme.colorScheme.surface)))),
                    ],
                  )
                ],
              ),
            )),
        BlockBaseWidget(
          header: 'Рекомендуем',
          child: Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MovieCard(
                  aspectRatio: 11 / 16,
                  margin: EdgeInsets.only(right: Indents.smd),
                ),
                MovieCard(
                  aspectRatio: 11 / 16,
                  margin: EdgeInsets.only(right: Indents.smd),
                ),
                MovieCard(
                  aspectRatio: 11 / 16,
                  margin: EdgeInsets.only(right: Indents.smd),
                ),
                MovieCard(
                  aspectRatio: 11 / 16,
                  margin: EdgeInsets.only(right: Indents.smd),
                ),
              ],
            ),
          ),
        ),
        // TODO: выбивает исключение
        BlockBaseWidget(
          header: 'Лучший плейлист',
          child: PlayListCard(
            aspectRatio: 16 / 9,
          ),
        ),
        BlockBaseWidget(
          header: 'Лучшее видео',
          child: VideoCard(
            aspectRatio: 16 / 9,
          ),
        )
      ],
    );
  }
}
