// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:musicc/main.dart';
import 'package:musicc/pages/songs.dart';
import 'package:musicc/pages/home.dart';

class Detailpage extends StatefulWidget {
  final Song song;
  final int index;
  final AudioPlayer audioPlayer;

  const Detailpage({
    super.key,
    required this.song,
    required this.index,
    required this.audioPlayer,
  });

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.redAccent,
              ),
              child: Image(image: AssetImage(widget.song.pathh_to_img)),
            ),
            SizedBox(
              height: 20,
            ),
            Text('${widget.song.titlee} by ${widget.song.name}'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await Pause_Play.playerr(context, widget.index, () {
                  setState(() {}); // Update the state to rebuild the UI
                });
              },
              child: Pause_Play.choose(),
            )
          ],
        ),
      ),
    );
  }
}
