import 'package:flutter/material.dart';
import 'package:meme_app/editMeme.dart';
import 'package:meme_app/home_page.dart';
import 'meme_data.dart';

class SelectMeme extends StatefulWidget {
  const SelectMeme({Key? key}) : super(key: key);

  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  int maxItems = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          shadowColor: Colors.grey,
          backgroundColor: Colors.amber[600],
          title: Text(
            'Select Meme',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: [
                for (var i = 0; i <= maxItems; i++)
                  RawMaterialButton(
                    onPressed: () {
                      print(memeName[i]);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return EditMeme(imageName: memeName[i]);
                        },
                      ));
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 4) / 3,
                      height: (MediaQuery.of(context).size.width - 4) / 3,
                      child: Image.asset(
                        'assets/meme/${memeName[i]}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
            maxItems < memeName.length
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        if (maxItems + 20 < memeName.length) {
                          maxItems += 20;
                        } else {
                          maxItems = memeName.length;
                        }
                      });
                    },
                    child: Text('load more'),
                  )
                : Container()
          ],
        )));
  }
}
