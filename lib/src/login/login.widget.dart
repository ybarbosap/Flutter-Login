import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:tela_logingf/src/login/screens/LoginPage.widget.dart';
import 'package:tela_logingf/src/login/screens/LoginSignInPage.dart';
import 'package:tela_logingf/src/login/screens/SignUpPage.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tela_logingf/src/provider/ProviderPageController.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  PageController _controller;

  String name;

  String email;

  String imageUrl;

  @override
  void initState() {
    super.initState();
    _controller = new PageController(initialPage: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Prop BoxFit.cover faz com que a imagem se adeque até que preecha toda a tela
          Image.asset(
            'assets/images/snow.jpeg',
            fit: BoxFit.cover,
          ),

          ProviderPageController(
            controller: _controller,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                SingleChildScrollView(
                    child: LoginSignUpPage(createNewUser: createNewUser)),
                LoginPage(),
                SingleChildScrollView(
                    child: LoginSignInPage(
                  googleSign: googleSign,
                  emailSign: emailSign,
                  facebookSign: facebookSign,
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createNewUser([String email, String passwaord]) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: passwaord);
    } catch (error) {
      print(error);
    }
  }

  Future<String> emailSign(String email, String password) async {
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      assert(user != null);
      return user.displayName;
    } catch (e) {
      return e;
    }
  }

  Future<FirebaseUser> googleSign() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult =
        await _auth.signInWithCredential(authCredential);

    final FirebaseUser firebaseUser = authResult.user;

    assert(firebaseUser.email != null);
    assert(firebaseUser.displayName != null);
    assert(firebaseUser.photoUrl != null);

    name = firebaseUser.displayName;
    email = firebaseUser.email;
    imageUrl = firebaseUser.photoUrl;

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);

    return currentUser;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<FirebaseUser> facebookSign() async {
    FacebookLoginResult result =
        await facebookLogin.logIn(['email', 'public_profile']);
    FirebaseUser currentUser;

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.getCredential(
          accessToken: accessToken.toString(),
        );

        await _auth.signInWithCredential(authCredential);

        currentUser = await _auth.currentUser();

        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
    return currentUser;
  }
}
