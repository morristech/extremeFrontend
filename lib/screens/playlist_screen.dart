import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/hint_chips.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../widgets/stats.dart';
import '../widgets/video_card.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:extreme/models/main.dart' as Models;

/// Создаёт экран просмотра плейлиста

class PlaylistScreen extends StatelessWidget {
  final Models.Playlist model;
  PlaylistScreen({Key key, @required this.model}) : super(key: key);

  void _searchIconAction() {}

  @override
  Widget build(BuildContext context) {
    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text(model?.content?.name ?? 'Название плейлиста'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchIconAction,
          ),
        ],
      ),
      builder: (context) => <Widget>[
        HeaderPlaylist(model: model),
        BlockBaseWidget(
          header: 'Видео',
          child: FutureBuilder(
            future: Api.Entities.getByIds<Models.Video>(model.videosIds),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CustomListBuilder(
                    items: snapshot.data,
                    itemBuilder: (item) =>
                        VideoCard(aspectRatio: 16 / 9, model: item));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
        BlockBaseWidget.forScrollingViews(
          header: 'Смотри также',
          child: FutureBuilder(
            future: Api.Entities.getAll<Models.Playlist>(1, 5, 'desc'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CustomListBuilder(
                    type: CustomListBuilderTypes.horizontalList,
                    height: 100,
                    items: snapshot.data,
                    itemBuilder: (item) => PlayListCard(
                          model: item,
                          aspectRatio: 16 / 9,
                          small: true,
                        ));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        )
      ],
    );
  }
}

/// Карточка плейлиста в самом верху страницы
class HeaderPlaylist extends StatelessWidget {
  final Models.Playlist model;

  HeaderPlaylist({this.model});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(model.content.image.path)
              ),
            ),
            child: Container(
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
            )),
        Positioned.fill(
          bottom: Indents.md,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: Indents.sm),
                    child: Text(
                        model?.content?.name ??
                            "Название плейлиста лалал лалала лала алала лалал ал аа лал ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.25))),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Indents.sm),
                    child: Text(
                        model?.content?.description ??
                            "Описание данного плейлиста",
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stats(
                        icon: Icons.thumb_up,
                        text: model.likesAmount.toString(),
                        marginBetween: 5,
                      ),
                      Stats(
                        icon: Icons.local_movies,
                        text: (model.videosIds?.length ?? 0).toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        model.isInPreferredLanguage ? Container() :HintChip.noLocalization(margin: EdgeInsets.only(left: Indents.sm))
      ],
    );
  }
}
