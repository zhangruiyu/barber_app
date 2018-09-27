import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

//reducer
final loadingReducer = combineReducers<bool>([
  new TypedReducer<bool, LoadingState>(_loadingState),
]);

bool _loadingState(bool isLoading, LoadingState action) {
  return action.isLoading;
}

//action

class LoadingState {
  bool isLoading = false;

  LoadingState(this.isLoading);
}
