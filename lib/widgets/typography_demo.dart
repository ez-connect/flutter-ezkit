import 'package:flutter/material.dart';

import '../utils.dart';

class TypographyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeEx.text;
    final themeData = ThemeEx.theme;

    return ListView(
      children: [
        Text('H1', style: textTheme.headline1),
        Text('Headline 2', style: textTheme.headline2),
        Text('Headline 3', style: textTheme.headline3),
        Text('Headline 4', style: textTheme.headline4),
        Text('Headline 5', style: textTheme.headline5),
        Text('Headline 6', style: textTheme.headline6),
        Text('Subtitle 1', style: textTheme.subtitle1),
        Text('Subtitle 2', style: textTheme.subtitle2),
        Text('Body 1', style: textTheme.bodyText1),
        Text('Body 2', style: textTheme.bodyText2),
        Text('Button', style: textTheme.button),
        Text('Caption', style: textTheme.caption),
        Text('Overline', style: textTheme.overline),
        Divider(),
        Text('accentColor', style: TextStyle(color: themeData.accentColor)),
        Text('backgroundColor',
            style: TextStyle(color: themeData.backgroundColor)),
        Text('bottomAppBarColor',
            style: TextStyle(color: themeData.bottomAppBarColor)),
        Text('buttonColor', style: TextStyle(color: themeData.buttonColor)),
        Text('canvasColor', style: TextStyle(color: themeData.canvasColor)),
        Text('cardColor', style: TextStyle(color: themeData.cardColor)),
        Text('dividerColor', style: TextStyle(color: themeData.dividerColor)),
        Text('disabledColor', style: TextStyle(color: themeData.disabledColor)),
        Text('cursorColor', style: TextStyle(color: themeData.cursorColor)),
        Text('errorColor', style: TextStyle(color: themeData.errorColor)),
        Text('focusColor', style: TextStyle(color: themeData.focusColor)),
        Text('highlightColor',
            style: TextStyle(color: themeData.highlightColor)),
        Text('hintColor', style: TextStyle(color: themeData.hintColor)),
        Text('hoverColor', style: TextStyle(color: themeData.hoverColor)),
        Text('indicatorColor',
            style: TextStyle(color: themeData.indicatorColor)),
        Text('primaryColor', style: TextStyle(color: themeData.primaryColor)),
        Text('scaffoldBackgroundColor',
            style: TextStyle(color: themeData.scaffoldBackgroundColor)),
      ],
    );
  }
}
