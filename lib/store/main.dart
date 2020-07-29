import 'package:extreme/main.dart';
import 'package:extreme/models/main.dart' as Models;
import 'package:extreme/services/localstorage.dart';
import 'package:extreme/store/info.dart';
import 'package:extreme/store/user/reducers.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class AppState {
  final Models.User user;
  final Info info;

  AppState({@required this.user, @required this.info});

  AppState.initialState()
      : user = Models.User.fromLocalStorage(),
        info = Info(likesCount: 1000);


}

AppState appStateReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
    info: infoReducer(state.info, action)
  );
}

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: AppState.initialState()
);