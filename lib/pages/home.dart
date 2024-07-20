// ignore_for_file: prefer_const_constructors, camel_case_types, use_build_context_synchronously, unused_import, avoid_print

// import 'dart:ffi';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musicc/pages/detail.dart';
import 'package:musicc/pages/songs.dart';
import 'package:musicc/pages/fetcherr.dart';

//player created
final AudioPlayer player = AudioPlayer();
bool playingg = false;
List<FileSystemEntity> _musicFiles = [];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      // Permission is granted, proceed with fetching music files
      _fetchMusicFiles();
    } else {
      // Permission is denied, handle the case
      print("Storage permission denied");
    }
  }

  Future<void> _fetchMusicFiles() async {
    // Get the directory containing music files
    const String customPath = '/storage/emulated/0/Music';
    final Directory customDir = Directory(customPath);
    if (await customDir.exists()) {
      print("Directory found: ${customDir.path}");

      // List all files in the directory
      setState(() {
        _musicFiles = customDir
            .listSync()
            .where((file) => file.path.endsWith('.mp3'))
            .toList();
      });

      print("Music files fetched: ${_musicFiles.length}");
    } else {
      print("Music directory not found");
    }
  }

  //Fetcherr._fetchMusicFiles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Locall Musiccc Player")),
      body: ListView.builder(
        itemCount: _musicFiles.length,
        itemBuilder: (context, index) {
          FileSystemEntity file = _musicFiles[index];
          return ListTile(
            title: Text(file.path.split('/ ').last),
            onTap: () {
              Pause_Play.playerr(context, index, () {
                setState(() {}); // Update the state to rebuild the UI
              });
            },
          );
        },
      ),
    );
  }
}

class Pause_Play {
  static Future<bool> playerr(
      BuildContext context, int index, VoidCallback updateState) async {
    print("$index in class");
    if (playingg == false) {
      try {
        await player.play(DeviceFileSource(_musicFiles[index].path));
        playingg = true;
        print("$index after play");

        // if (ModalRoute.of(context)?.settings.name != '/detailpage') {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       settings: RouteSettings(name: '/detailpage'),
        //       builder: (context) => Detailpage(
        //         song: _musicFiles[index],
        //         audioPlayer: player,
        //         index: index,
        //       ),
        //     ),
        //   );
        // }
      } catch (e) {
        print("Error occurred while playing audio: $e");
      }
    } else {
      print("$playingg before pause");
      player.pause();
      playingg = false;
      print("$playingg after pause");
    }
    updateState(); // Call the update state callback to rebuild the UI

    return playingg;
  }

  static Future<void> nextMusic(
      BuildContext context, int index, VoidCallback updateState) async {
    index += index;
    // print('ttttttttttt');
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
