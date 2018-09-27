import 'package:barber_app/widget/BackButtonArrows.dart';
import 'package:flutter/material.dart';

class Toolbar extends AppBar {
  Toolbar({
    Key key,
    Widget leading: const BackButtonArrows(),
    bool automaticallyImplyLeading: true,
    Widget title,
    List<Widget> actions,
    Widget flexibleSpace,
    PreferredSizeWidget bottom,
    double elevation: 0.0,
    Color backgroundColor,
    Brightness brightness,
    IconThemeData iconTheme,
    TextTheme textTheme,
    bool primary: true,
    bool centerTitle,
    double titleSpacing: NavigationToolbar.kMiddleSpacing,
    double toolbarOpacity: 1.0,
    double bottomOpacity: 1.0,
  }) : super(
            key: key,
            leading: leading,
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: title,
            actions: actions,
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            elevation: elevation,
            backgroundColor: backgroundColor,
            brightness: brightness,
            iconTheme: iconTheme,
            textTheme: textTheme,
            primary: primary,
            centerTitle: centerTitle,
            titleSpacing: titleSpacing,
            toolbarOpacity: toolbarOpacity,
            bottomOpacity: bottomOpacity);
}
