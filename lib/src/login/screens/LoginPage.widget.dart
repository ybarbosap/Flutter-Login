import 'package:flutter/material.dart';

import '../../provider/ProviderPageController.dart';
import '../../widgets/foneIcon.widget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: MediaQuery.of(context).size.height,
      color: Colors.red.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FoneIcon(
            color: Colors.white,
          ),
          Text(
            'AwesomeApp',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(40)),
                onPressed: () {
                  ProviderPageController.of(context).toPage(page: 0);
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              color: Colors.white,
              onPressed: () {
                ProviderPageController.of(context).toPage(page: 2);
              },
              child: Text('LOGIN',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
