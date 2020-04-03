import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  CustomTextField(
      {@required this.text,
      @required this.label,
      @required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            child: Text(text,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start)),
        SizedBox(height: 13),
        TextField(
          obscureText: obscureText,
          controller: controller,
          autofocus: false,
          decoration: InputDecoration(
              labelText: label,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              disabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        )
      ],
    );
  }
}
