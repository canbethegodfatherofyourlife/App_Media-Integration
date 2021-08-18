import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/sign_in_methods.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    double unitHeightValue = height * 0.001;
    return Scaffold(
      body: Container(
        padding:EdgeInsets.symmetric(horizontal: width/22),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL!,
                ),
                radius:height/8,
              ),
              SizedBox(height:height/10),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize:  25* unitHeightValue,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: TextStyle(
                    fontSize: 22* unitHeightValue,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height/15),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize:  25* unitHeightValue,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: TextStyle(
                    fontSize: 22 * unitHeightValue,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height/10),
              RaisedButton(
                onPressed: () async {
                  await providerID=="google"?signOutGoogle():signOutFacebook();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 28* unitHeightValue, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}