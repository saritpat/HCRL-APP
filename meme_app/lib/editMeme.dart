// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_new
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class EditMeme extends StatefulWidget {
  final String imageName;
  const EditMeme({Key? key, required this.imageName}) : super(key: key);

  @override
  _EditMemeState createState() => _EditMemeState();
}

class _EditMemeState extends State<EditMeme> {
  String topText = '';
  String bottomText = '';
  GlobalKey globalKey = new GlobalKey();
  double xTop = 50, yTop = 100, xBot = 50, yBot = 180;

  @override
  void initState() {
    super.initState();
    topText = 'Top Text';
    bottomText = 'Bottom Text';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text(
          'Add Text',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Stack(
              children: [
                DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Image.asset('assets/meme/${widget.imageName}.jpg');
                  },
                  onAcceptWithDetails: (DragTargetDetails<String> details) {
                    var newX =
                        details.offset.dx - MediaQuery.of(context).padding.left;
                    var newY = details.offset.dy -
                        MediaQuery.of(context).padding.top -
                        AppBar().preferredSize.height;

                    setState(() {
                      if (details.data == 'top') {
                        xTop = newX;
                        yTop = newY;
                      } else if (details.data == 'bottom') {
                        xBot = newX;
                        yBot = newY;
                      }
                    });
                  },
                ),
                Positioned(
                  top: yTop,
                  left: xTop,
                  child: Draggable<String>(
                    data: 'top',
                    child: buildStrokeText(topText),
                    feedback: buildStrokeText(topText),
                    childWhenDragging: Container(),
                  ),
                ),
                Positioned(
                  top: yBot,
                  left: xBot,
                  child: Draggable<String>(
                    data: 'bottom',
                    child: buildStrokeText(bottomText),
                    feedback: buildStrokeText(bottomText),
                    childWhenDragging: Container(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      topText = text;
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
                      hintText: 'Top Text'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      bottomText = text;
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
                      hintText: 'Bottom Text'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          exportMeme();
                        },
                        icon: Icon(Icons.outbox_rounded),
                        label: Text(
                          'Export',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Stack buildStrokeText(String text) {
    return Stack(
      children: [
        Text(text,
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            )),
        Text(text,
            style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }

/////////////////////////////////////

  void exportMeme() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      final directory = (await getApplicationDocumentsDirectory()).path;

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngByte = byteData.buffer.asUint8List();
      File imageFile = File('$directory/meme.png');
      imageFile.writeAsBytesSync(pngByte);

      Share.shareFiles(['$directory/meme.png']);
    } catch (e) {
      print(e);
    }
  }

/////////////////////////////////////

}
