import 'package:flutter/material.dart';
import 'package:flutter_app/sign_in_methods.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () async {
                Navigator.of(context).restorablePush(_dialogBuilder);
                await signInWithGoogle().then((result) {
                  Navigator.pop(context);
                  if (result != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return FirstScreen();
                        },
                      ),
                    );
                  }
                }).catchError((e) => handleError(e, context));
              },
            ),
            Divider(),
            SignInButton(
              Buttons.Facebook,
              onPressed: () async {
                Navigator.of(context).restorablePush(_dialogBuilder);
                await signInWithFacebook().then((result) {
                  Navigator.pop(context);
                  if (result != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return FirstScreen();
                        },
                      ),
                    );
                  }
                }).catchError((e) => handleError(e, context));
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void handleError(var err, BuildContext context) {
    Navigator.pop(context);
    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        err.toString(),
        style: TextStyle(color: Colors.blueAccent),
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}
