import 'package:flutter/material.dart';

import 'package:share/share.dart';

class ShareButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final String? subject;

  const ShareButton({
    Key? key,
    this.icon,
    this.text,
    this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: this.icon!, onPressed: this._onPressed);
  }

  void _onPressed() {
    Share.share(this.text!, subject: this.subject);
  }
}
