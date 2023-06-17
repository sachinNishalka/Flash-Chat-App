import 'package:flutter/material.dart';
import 'package:flashchat/components/roundedButton.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
// create a variable to store bool data for spinner
  bool showSpinner = false;

  late String userName;
  late String password;

  FirebaseAuth registeredUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                keyboardType: TextInputType.emailAddress,
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
                func: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    var user =
                        await registeredUser.createUserWithEmailAndPassword(
                            email: userName, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } on Exception catch (e) {
                    print(e);
                  }
                },
                text: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
