import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser currentUser;

  HomePage({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Area restrita')),
      body: Center(
          child: currentUser != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Image.network(currentUser.photoUrl),
                      Text('Nome: ${currentUser.displayName}'),
                      Text('Email: ${currentUser.email}')
                    ])
              : Text('Usuário logado')),
    );
  }
}
