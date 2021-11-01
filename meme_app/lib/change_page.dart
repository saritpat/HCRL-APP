import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/home_page.dart';

class ChangePage extends StatefulWidget {
  const ChangePage({Key? key}) : super(key: key);

  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  String newPassword = '';
  String oldPassword = '';
  final auth = FirebaseAuth.instance;
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
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 40,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Change Password',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              obscureText: true,
              onChanged: (text) {
                setState(() {
                  newPassword = text;
                });
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                  hintText: 'New Password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextButton(
              onPressed: () {
                changePassword();
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
        ],
      ),
    );
  }

  void changePassword() async {
    try {
      await auth.currentUser!.updatePassword(newPassword);
      print('Password Changed ! ! !');
      _showDialogGo('Password Changed ! ! !', '^_^');
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      switch (e.code) {
        case 'requires-recent-login:':
          eMessage =
              "User's last sign in time does not meet the security threshold. Log out and try again.";
          break;
        case 'weak-password':
          eMessage = 'Password should be at least 6 characters.';
          break;
      }
      _showDialog('Change Password Error', eMessage);
    }
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

  void _showDialogGo(head, body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(head),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              child: new Text("Back To Home"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        );
      },
    );
  }
}
