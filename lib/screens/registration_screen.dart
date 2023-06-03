import 'package:flutter/material.dart';
import 'package:flashchat/components/roundedButton.dart';
import 'package:flashchat/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String userName;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,

              onChanged: (value) {
                userName = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your email"),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: "Enter your password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            paddingButtons(
              color: Colors.blueAccent,
              func: () {
                print("username : $userName");
                print("passeord : $password");
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
