import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String eMessage = '';
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          shadowColor: Colors.grey,
          backgroundColor: Colors.amber[600],
          title: Center(
              child: Text(
            'Register/Login',
            style: TextStyle(fontSize: 24),
          )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(children: [
                  Text(
                    'Meme Generator',
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
                    'Meme Generator',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.amber[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ])),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'Insert Email here'),
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password', hintText: 'Insert Password here'),
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                  print('Registered ! ! !');
                  getName();
                  getUser();
                  getEmail();
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                  print(e.message);
                  switch (e.code) {
                    case 'weak-password':
                      eMessage = 'Password should be at least 6 characters';
                      break;
                    case 'email-already-in-use':
                      eMessage =
                          'The email address is already in use by another account.';
                      break;
                    case 'operation-not-allowed:':
                      eMessage =
                          'email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.';
                      break;
                  }
                  _showDialog('Register Failed', eMessage);
                }
              },
              icon: Icon(Icons.open_in_new),
              label: Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[700],
                shadowColor: Colors.white60,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await auth.signInWithEmailAndPassword(
                      email: _email, password: _password);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                  print('Loging In ! ! !');
                  getName();
                  getUser();
                  getEmail();
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                  print(e.message);
                  switch (e.code) {
                    case 'too-many-requests':
                      eMessage =
                          'We have blocked all requests from this device due to unusual activity. Try again later.';
                      break;
                    case 'invalid-email':
                      eMessage = 'Email address is not valid.';
                      break;
                    case 'user-disabled':
                      eMessage =
                          'User corresponding to the given email has been disabled.';
                      break;
                    case 'user-not-found':
                      eMessage =
                          'User not found. The user may have been deleted.';
                      break;
                    case 'wrong-password':
                      eMessage = 'The password is invalid.';
                      break;
                  }
                  _showDialog('Log In Failed', eMessage);
                }
              },
              icon: Icon(Icons.login_rounded),
              label: Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[700],
                shadowColor: Colors.white60,
              ),
            ),
          ],
        ));
  }

  void _showDialog(head, body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(head),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getUser() async {
    final User user = await auth.currentUser!;
    final userid = user.uid;
    print(userid);
  }

  void getEmail() async {
    final User user = await auth.currentUser!;
    final emailid = user.email;
    print(emailid);
  }

  void getName() async {
    final User user = await auth.currentUser!;
    final nameid = user.displayName;
    print(nameid);
  }
}
