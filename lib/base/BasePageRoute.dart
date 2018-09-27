import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BaseRoute<T> extends MaterialPageRoute<T> {
  BaseRoute({@required Widget widget, @required String name})
      : super(
            builder: (BuildContext context) {
              return widget;
            },
            settings: RouteSettings(name: name));
}

abstract class RouteAttribute<F> {
  String getRouteName();
}

//F为返回值类型
abstract class BasePageRoute<F> extends StatefulWidget
    implements RouteAttribute {
  BasePageRoute({Key key}) : super(key: key);

  BaseRoute<F> route() {
    return new BaseRoute<F>(widget: this, name: getRouteName());
  }
}

abstract class BasePageLessRoute<F> extends StatelessWidget
    implements RouteAttribute {
  BaseRoute<F> toRoute() {
    return new BaseRoute<F>(widget: this, name: getRouteName());
  }
}
