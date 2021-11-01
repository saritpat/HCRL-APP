import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/auth_page.dart';
import 'package:meme_app/selectMeme.dart';

import 'change_page.dart';

class HomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  PageController pageController = PageController(initialPage: 0);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String eMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Colors.amber[600],
        leading: IconButton(
            onPressed: () {
              pageController.animateToPage(0,
                  duration: Duration(milliseconds: 170),
                  curve: Curves.bounceInOut);
            },
            icon: Icon(
              Icons.home,
              size: 40,
            )),
        title: Center(
            child: Text(
          'Home/Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        )),
        actions: [
          IconButton(
              onPressed: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 170),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.person,
                size: 40,
              ))
        ],
      ),
      body: Center(
        child: PageView(
          pageSnapping: true,
          controller: pageController,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                // color: Colors.blueGrey[50],
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/eclipse.png',
                            scale: 1,
                          ),
                          Image.asset(
                            'assets/eclipse.png',
                            scale: 1.14,
                            color: Colors.blueGrey[50],
                          ),
                          Image.asset(
                            'assets/shiba.png',
                            scale: 1.3,
                          ),
                        ],
                      ),
                    ),
                    Stack(children: [
                      Text(
                        'Home',
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 10
                            ..color = Colors.yellow.shade400,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.amber[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SelectMeme()));
                        },
                        icon: Icon(Icons.double_arrow_rounded),
                        label: Text(
                          'Select Meme',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[700],
                          shadowColor: Colors.white60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 230),
                      child: Text(
                        'Swipe >>',
                        style: TextStyle(
                          color: Colors.blueGrey[100],
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey[50],
                ),
                // color: Colors.blueGrey[50],
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.circle,
                              size: 175,
                              color: Colors.grey[800],
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.circle,
                              size: 170,
                              color: Colors.grey,
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.person,
                              size: 150,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 10
                            ..color = Colors.yellow.shade400,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.amber[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            'User ID : ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${getUser()}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            'Email : ',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${getEmail()}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ChangePage()));
                        },
                        child: Text(
                          'Change Password',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[700],
                          shadowColor: Colors.white60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          auth.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AuthPage()));
                        },
                        icon: Icon(Icons.logout_rounded),
                        label: Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[700],
                          shadowColor: Colors.white60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        '<< Swipe',
                        style: TextStyle(
                          color: Colors.blueGrey[100],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getUser() {
    final User user = auth.currentUser!;
    final userid = user.uid;
    return userid;
  }

  String? getEmail() {
    final User user = auth.currentUser!;
    final emailid = user.email;
    return emailid;
  }
}
