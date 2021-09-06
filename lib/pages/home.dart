import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account!);
    }, onError: (err) {
      print("Error: $err");
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account!);
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    // ignore: unnecessary_null_comparison
    if (account != null) {
      print('User: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      print(account);
      setState(() {
        isAuth = false;
      });
    }
  }

  loginUser() {
    googleSignIn.signIn();
  }

  logoutUser() {
    googleSignIn.signOut();
  }

  Widget buildAuthScreen() {
    return ElevatedButton(onPressed: logoutUser, child: Text("Logout"));
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.teal, Colors.purple],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'FreeNetworkSocial',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 60.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/google_signin_button.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
