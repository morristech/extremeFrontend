import 'package:extreme/helpers/snack_bar_extension.dart';
import 'package:extreme/lang/app_localizations.dart';
import 'package:extreme/main.dart';
import 'package:extreme/helpers/app_localizations_helper.dart';
import 'package:extreme/store/main.dart';
import 'package:extreme/store/user/actions.dart';
import 'package:extreme/styles/extreme_colors.dart';
import 'package:extreme/services/api/main.dart' as Api;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FavoriteToggler extends StatelessWidget {
  final bool status;
  final int id;
  final String toolTip;

  FavoriteToggler({this.status, this.id, this.toolTip});

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context).withBaseKey('snack_bars.favorite');
    var icon = status ? Icons.favorite : Icons.favorite_border;
    var color = status ? ExtremeColors.error : Colors.white;
    var toolTipText =
        toolTip ?? AppLocalizations.of(context).translate('tooltips.favorite');

    return IconButton(
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(0),
      icon: Icon(
        icon,
        color: color,
        size: 30,
      ),
      tooltip: toolTipText,
      onPressed: () async {
        // #favorites
        // тут коллим добавление в избранное к апи и диспатчим экшн для изменения стора

        // TODO: можно отрефакторить в Redux Thunk
        var userAction = await Api.User.toggleFavorite(id);
        if (userAction == null) return;

        StoreProvider.of<AppState>(context)
            .dispatch(ToggleFavorite(userAction));
        rootScaffold.currentState.showSnackBar(SnackBarExtension.info(
            loc.translate(userAction.status ? 'added' : 'removed')));
      },
    );
  }
}
