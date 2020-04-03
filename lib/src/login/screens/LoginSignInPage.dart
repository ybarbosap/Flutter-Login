import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/custonTextField.dart';
import '../../widgets/foneIcon.widget.dart';
import '../../login/screens/home.dart';

class LoginSignInPage extends StatelessWidget {
  final Future<FirebaseUser> Function() googleSign;

  final Future<FirebaseUser> Function() facebookSign;

  final Future<String> Function(String, String) emailSign;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String get email => emailController.text;

  String get password => passwordController.text;

  LoginSignInPage({
    this.googleSign,
    this.emailSign,
    this.facebookSign,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueriSize = MediaQuery.of(context).size;

    return Container(
      height: mediaQueriSize.height,
      color: Colors.white.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FoneIcon(color: Colors.red, ativeBottom: true),
          CustomTextField(
              text: 'EMAIL',
              label: 'ybarbosap@gmail.com',
              controller: emailController),
          CustomTextField(
              text: 'PASSWORD',
              label: '**********',
              controller: passwordController,
              obscureText: true),
          Container(
              width: mediaQueriSize.width,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Forgot Password ?',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end)),
          Container(
            width: mediaQueriSize.width,
            height: 60,
            child: FlatButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                'LOGIN',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                emailSign(email, password).then((username) => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage())));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Stack(
              children: <Widget>[
                Divider(color: Colors.black),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR CONNECT WITH',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  width: mediaQueriSize.width * 0.4,
                  height: 60,
                  child: FlatButton(
                      color: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      onPressed: () {
                        facebookSign().then((currentUser) {
                          if (currentUser != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    HomePage(currentUser: currentUser),
                              ),
                            );
                          }
                        });
                      },
                      child: Text('FACEBOOK',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center))),
              Container(
                  width: mediaQueriSize.width * 0.4,
                  height: 60,
                  child: FlatButton(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      onPressed: () async {
                        googleSign().then((currentUser) {
                          if (currentUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        HomePage(currentUser: currentUser)));
                          }
                        });
                      },
                      child: Text('GOOGLE',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center))),
            ],
          ),
        ],
      ),
    );
  }
}
