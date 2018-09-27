import 'package:barber_app/helpers/user_helper.dart';
import 'package:barber_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

//reducer
final authReducer = combineReducers<User>([
  new TypedReducer<User, LogInSuccessful>(_logIn),
  new TypedReducer<User, LogOutSuccessful>(_logOut),
]);

User _logIn(User user, LogInSuccessful action) {
  UserHelper.saveData(action.user);
  return action.user;
}

Null _logOut(User user, action) {
  UserHelper.saveData(null);
  return null;
}

//action
class LogIn {
  LogIn();
}

class LogInSuccessful {
  final User user;

  LogInSuccessful({@required this.user});

  @override
  String toString() {
    return 'LogIn{user: $user}';
  }
}

class LogInFail {
  final dynamic error;

  LogInFail(this.error);

  @override
  String toString() {
    return 'LogIn{There was an error logging in: $error}';
  }
}

class LogOut {}

class LogOutSuccessful {
  LogOutSuccessful();

  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}

class LogOutFail {
  final dynamic error;

  LogOutFail(this.error);

  String toString() {
    return '{There was an error logging out: $error}';
  }
}
