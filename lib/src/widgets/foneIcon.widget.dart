import 'package:flutter/material.dart';

class FoneIcon extends StatelessWidget {
  final bool ativeBottom;
  final Color color;

  FoneIcon({this.ativeBottom = false, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: ativeBottom
            ? EdgeInsets.only(bottom: 80)
            : EdgeInsets.only(bottom: 0),
        child: Icon(Icons.headset_mic, color: color, size: 60));
  }
}
