import 'dart:async';

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

class OfflineWarning extends StatefulWidget {
  final Icon icon;
  final Widget child;

  const OfflineWarning({Key? key, required this.icon, required this.child})
      : super(key: key);

  @override
  _OfflineWarningState createState() => _OfflineWarningState();
}

class _OfflineWarningState extends State<OfflineWarning> {
  late StreamSubscription<ConnectivityResult> _subscription;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    this._subscription = Connectivity().onConnectivityChanged.listen((event) {
      final visible = event == ConnectivityResult.none;
      this.setState(() {
        this._visible = visible;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    this._subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this._visible,
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            this.widget.icon,
            SizedBox(width: 6),
            this.widget.child,
          ],
        ),
      ),
    );
  }
}
