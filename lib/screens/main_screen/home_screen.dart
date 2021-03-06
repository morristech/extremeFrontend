import 'package:carousel_pro/carousel_pro.dart';
import 'package:extreme/helpers/interfaces.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/models/main.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/styles/intents.dart';
import 'package:extreme/widgets/block_base_widget.dart';
import 'package:extreme/widgets/custom_future_builder.dart';
import 'package:extreme/widgets/custom_list_builder.dart';
import 'package:extreme/widgets/playlist_card.dart';
import 'package:extreme/widgets/screen_base_widget.dart';
import 'package:extreme/widgets/sport_card.dart';
import 'package:extreme/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/api/main.dart' as Api;

// Домашняя страница пользователя - Главная

class HomeScreen extends StatelessWidget implements IWithNavigatorKey {
  final Key navigatorKey;

  HomeScreen({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context).withBaseKey('home_screen');
    var store = StoreProvider.of<AppState>(context);

    return ScreenBaseWidget(
      padding: EdgeInsets.only(bottom: ScreenBaseWidget.screenBottomIndent),
      appBar: AppBar(
        title: Text('Extreme Insiders'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/search');
            },
          ),
        ],
      ),
      navigatorKey: navigatorKey,
      builder: (context) => <Widget>[
        CustomFutureBuilder(
          future: Api.Helper.getBanner(),
          builder: (data) {
            return Container(
              margin: EdgeInsets.only(bottom: Indents.md),
              child: HeadBanner(
                contents: data,
              ),
            );
          },
        ),
        BlockBaseWidget.forScrollingViews(
          header: loc.translate('interesting_sports'),
          child: FutureBuilder(
            future: Api.Entities.getAll<Models.Sport>(1, 8),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CustomListBuilder(
                    type: CustomListBuilderTypes.horizontalList,
                    height: 50,
                    items: snapshot.data,
                    itemBuilder: (item) => SportCard(
                        model: item, aspectRatio: 3 / 1, small: true));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
        BlockBaseWidget(
          header: loc.translate('recommended_videos'),
          child: CustomFutureBuilder<List<Models.Video>>(
            future: Api.Entities.recommended<Models.Video>(1, 2),
            builder: (data) {
              return CustomListBuilder(
                  items: data,
                  itemBuilder: (item) => VideoCard(
                        model: item,
                        aspectRatio: 16 / 9,
                      ));
            },
          ),
        ),
        BlockBaseWidget.forScrollingViews(
          margin: EdgeInsets.zero,
          header: loc.translate('last_updates'),
          child: CustomFutureBuilder(
            future: Api.Entities.getAll<Models.Playlist>(1, 10),
            builder: (data) {
              return CustomListBuilder<Models.Playlist>(
                  type: CustomListBuilderTypes.horizontalList,
                  height: 100,
                  items: data,
                  itemBuilder: (item) => PlayListCard(
                      model: item, aspectRatio: 16 / 9, small: true));
            },
          ),
        ),
      ],
    );
  }
}

class BannerInfo extends StatefulWidget {
  final List models;

  BannerInfo({Key key, this.models}) : super(key: key);

  //void updateInfo(int index);
  @override
  _BannerInfoState createState() => _BannerInfoState();
}

class _BannerInfoState extends State<BannerInfo> {
  int modelId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  void updateInfo(int index) {
    setState(() {
      modelId = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('GT3 Today', style: Theme.of(context).textTheme.headline6),
          Text('Race starts in 17:00 an Monza today',
              style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.7)))),
          Container(
            height: 25,
          )
        ],
      ),
    );
  }
}

class BannerInformation extends StatelessWidget {
  final int id;
  final Models.Content content;

  const BannerInformation({Key key, this.id, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(content?.name ?? 'No name. id: ' + id.toString(),
              style: Theme.of(context).textTheme.headline6),
          // Text(content?.description ?? 'No description provided',
          //     style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
          //         color: Theme.of(context)
          //             .colorScheme
          //             .onPrimary
          //             .withOpacity(0.7)))),
          Container(
            height: 25,
          )
        ],
      ),
    );
  }
}

class HeadBanner extends StatefulWidget {
  final List<Content> contents;

  HeadBanner({this.contents});

  @override
  _HeadBannerState createState() => _HeadBannerState();
}

class _HeadBannerState extends State<HeadBanner> {
  int index = 0;
  List<Content> contents;

  @override
  Widget build(BuildContext context) {
    contents = widget.contents;
    return SizedBox(
      height: 250.0,
      child: Stack(
        children: [
          Carousel(
            images: contents
                .map((e) => NetworkImage(e?.image?.path ??
                    'https://img3.akspic.ru/image/20093-parashyut-kaskader-kuala_lumpur-vozdushnye_vidy_sporta-ekstremalnyj_vid_sporta-1920x1080.jpg'))
                .toList(),
            // TODO: fetch photos with rest api
            // images: [
            //   NetworkImage(
            //       'https://all4desktop.com/data_images/original/4234511-formula-1.jpg'),
            //   ExactAssetImage("assets/images/extreme2.jpg"),
            //   ExactAssetImage("assets/images/extreme2.jpg"),
            //   ExactAssetImage("assets/images/extreme2.jpg"),
            //   // TODO: сделать компонент под дизайн
            // ],
            dotSize: Indents.md / 2,
            dotSpacing: Indents.lg,
            dotColor: Theme.of(context).backgroundColor,
            indicatorBgPadding: 10.0,
            borderRadius: false,
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            overlayShadow: true,
            overlayShadowColors: Theme.of(context).colorScheme.background,
            overlayShadowSize: 1,
            onImageChange: (previous, current) {
              setState(() {
                index = current;
              });
            },
          ),
          BannerInformation(
            id: index,
            content: contents[index],
          ),
        ],
      ),
    );
  }
}
