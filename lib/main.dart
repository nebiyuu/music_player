// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AudioPlayer player = AudioPlayer();
  int what = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("what"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              String path =
                  'ms/The_Weeknd_Heartless_Lyrics__RwnE0xR50ms_140.mp3';
              if (what == 0) {
                try {
                  print("Trying to play audio from: $path");
                  await player.play(AssetSource(path));
                  print("Audio started successfully.");
                  what = 1;
                } catch (e) {
                  print("Error occurred while playing audio: $e");
                }
              } else {
                player.pause();
                what = 0;
              }
            },
            child: ListTile(
              title: Text('what'),
              leading:
                  Image.asset('assets/img/pp.jpg'), // Ensure correct image path
            ),
          );
        },
      ),
    );
  }
}
