import 'package:flutter/material.dart';

import '../utils.dart';

class Paper extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;

  Paper({Key key, this.padding, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeEx.theme.cardColor,
      padding: this.padding,
      child: this.child,
    );
  }
}
