import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

class OfflineWarning extends StatelessWidget {
  final Icon icon;
  final Widget child;

  const OfflineWarning({
    Key key,
    @required this.icon,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Visibility(
          visible: snapshot.data == ConnectivityResult.none,
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                this.icon,
                SizedBox(width: 6),
                this.child,
              ],
            ),
          ),
        );
      },
    );
  }
}
