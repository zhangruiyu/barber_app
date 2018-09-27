import 'package:barber_app/models/app_state.dart';
import 'package:barber_app/reducers/auth_redux.dart';
import 'package:barber_app/reducers/loading_redux.dart';

AppState appReducer(state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    currentUser: authReducer(state.currentUser, action),
  ); //new
}
