import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freenetworksocial/pages/activity_feed.dart';
import 'package:freenetworksocial/pages/profile.dart';
import 'package:freenetworksocial/pages/search.dart';
import 'package:freenetworksocial/pages/timeline.dart';
import 'package:freenetworksocial/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  late PageController pageController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account!);
    }, onError: (err) {
      print("Error: $err");
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account!);
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);
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

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
