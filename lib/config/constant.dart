import 'package:barber_app/models/app_state.dart';
import 'package:barber_app/reducers/app_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

const refreshDelay = 200;
bool isOnLine = true;
SharedPreferences sp;
var store = new Store<AppState>(
  appReducer,
  initialState: new AppState(),
  distinct: true,
  middleware: []
//        ..addAll(createAuthMiddleware(context))
    ..add(thunkMiddleware)
    ..add(new LoggingMiddleware.printer()), //new
);
