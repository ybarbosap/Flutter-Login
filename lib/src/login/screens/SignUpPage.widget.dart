import 'package:flutter/material.dart';

import '../../provider/ProviderPageController.dart';
import '../../widgets/custonTextField.dart';
import '../../widgets/foneIcon.widget.dart';

class LoginSignUpPage extends StatelessWidget {
  final Future<void> Function(String, String) createNewUser;

  final confirmPasswordController = TextEditingController();

  final passwordController = TextEditingController();

  final emailController = TextEditingController();

  LoginSignUpPage({@required this.createNewUser});

  @override
  Widget build(BuildContext context) {
    var textStyleAcc = TextStyle(
        color: Theme.of(context).accentColor, fontWeight: FontWeight.bold);
    var textStyleWhite =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FoneIcon(color: Colors.red, ativeBottom: true),
          CustomTextField(
              text: 'EMAIL',
              label: 'ybarbosap@gmail.com',
              controller: emailController),
          SizedBox(height: 15),
          CustomTextField(
              text: 'PASSWORD',
              label: '**********',
              controller: passwordController,
              obscureText: true),
          SizedBox(height: 15),
          CustomTextField(
              text: 'CONFIRM PASSWORD',
              label: '**********',
              controller: confirmPasswordController,
              obscureText: true),
          SizedBox(height: 15),
          Container(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                  onTap: () =>
                      ProviderPageController.of(context).toPage(page: 2),
                  child: Text('Already have an account ?',
                      style: textStyleAcc, textAlign: TextAlign.end))),
          SizedBox(height: 60),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: FlatButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Text('SignUp', style: textStyleWhite),
                onPressed: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    createNewUser(
                        emailController.text, passwordController.text);
                    ProviderPageController.of(context).toPage(page: 2);
                  }
                },
              ))
        ],
      ),
    );
  }
}
