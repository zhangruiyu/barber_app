import 'package:barber_app/actions/counter_actions.dart';
import 'package:redux/redux.dart';

final counterReducer = combineReducers<int>([
  new TypedReducer<int, IncrementCountAction>(_incrementCount),
]);

int _incrementCount(int currentCount, action) {
  return currentCount + 1;
}
