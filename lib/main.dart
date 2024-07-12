// ignore_for_file: prefer_const_constructors, camel_case_types, use_build_context_synchronously

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musicc/pages/detail.dart';
import 'package:musicc/pages/songs.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

//player created
final AudioPlayer player = AudioPlayer();
bool playingg = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("music"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: week.length,
        itemBuilder: (context, index) {
          String ass = week[index].pathh_to_img;
          return GestureDetector(
            onTap: () {
              // Within the `FirstRoute` widget:
              Pause_Play.playerr(context, index, () {
                setState(() {}); // Update the state to rebuild the UI
              });
            },
            child: ListTile(
              title: Text(week[index].name),

              leading: Image.asset(ass), // Ensure correct image path
            ),
          );
        },
      ),
    );
  }
}

class Pause_Play {
  static Future<bool> playerr(
      BuildContext context, int index, VoidCallback updateState) async {
    //print("$playingg in class");
    if (playingg == false) {
      try {
        await player.play(AssetSource(week[index].pathh));
        playingg = true;
        //print("$index after play");

        if (ModalRoute.of(context)?.settings.name != '/detailpage') {
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(name: '/detailpage'),
              builder: (context) => Detailpage(
                song: week[index],
                audioPlayer: player,
                index: index,
              ),
            ),
          );
        }
      } catch (e) {
        //print("Error occurred while playing audio: $e");
      }
    } else {
      //print("$playingg before pause");
      player.pause();
      playingg = false;
      //print("$playingg after pause");
    }
    updateState(); // Call the update state callback to rebuild the UI

    return playingg;
  }

  static Future<void> nextMusic(
      BuildContext context, int index, VoidCallback updateState) async {
    index += index;
    //print('ttttttttttt');
    // playerr(context, index, () {
    //   setState(() {}); // Update the state to rebuild the UI
    // });
    updateState(); // Call the update state callback to rebuild the UI
  }

  static Icon choose() {
    if (playingg == true) {
      Icon icc = Icon(Icons.pause_circle_filled);
      return icc;
    } else {
      Icon icc = Icon(Icons.play_circle_fill);
      return icc;
    }
  }
}
