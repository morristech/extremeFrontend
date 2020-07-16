import 'package:extreme/helpers/aspect_ratio_mixin.dart';
import 'package:extreme/helpers/indents_mixin.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/styles/intents.dart';
import 'package:flutter/material.dart';

import 'stats.dart';

class PlayListCard extends StatelessWidget with IndentsMixin, AspectRatioMixin {
  final bool small;

  PlayListCard({EdgeInsetsGeometry margin, EdgeInsetsGeometry padding, double aspectRatio, this.small = false}) {
    this.margin = margin;
    this.padding = padding;
    this.aspectRatio = aspectRatio;
  }

  // TODO: Добавить рипл эффект как на sport_card
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return withIndents(
      child: withAspectRatio(
        child: Card(
          margin: EdgeInsets.all(0),
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage("extreme2.jpg"),
                ),
              ),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              ExtremeColors.base.withOpacity(0.0),
                              ExtremeColors.base.withOpacity(0.75)
                            ],
                            center: Alignment.center,
                            radius: 1.5,
                            stops: <double>[0, 1],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                // TODO: выделить в отдельный компонент и состояние когда кнопка активна(иконка залита красным цветом(объект в избранном))
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.all(Indents.md),
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                ),
                                tooltip: 'Placeholder',
                                onPressed: () {},
                              ),
                            ]),
                        Container(
                          padding: EdgeInsets.all(Indents.md),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Stats(
                                        icon: Icons.thumb_up,
                                        text: '1555',
                                        marginBetween: Indents.sm,
                                        widgetMarginRight: Indents.md,
                                      ),
                                    ),
                                    Stats(
                                        icon: Icons.local_movies,
                                        text: '89',
                                        marginBetween: Indents.sm),
                                  ],
                                ),
                                Text(
                                  "Название плейлиста",
                                  style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto',
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "Достаточно Краткое описание плейлиста",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .merge(new TextStyle(color: Colors.white)),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}
