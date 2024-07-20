// // ignore_for_file: avoid_print, prefer_const_constructors

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:musicc/pages/home.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Fetcherr  {
//   List<FileSystemEntity> _musicFiles = [];


//   Future<void> _requestPermissions() async {
//     // Request storage permission
//     if (await Permission.storage.request().isGranted) {
//       // Permission is granted, proceed with fetching music files
//       _fetchMusicFiles();
//     } else {
//       // Permission is denied, handle the case
//       print("Storage permission denied");
//     }
//   }

//   Future<void> _fetchMusicFiles() async {
//     // Get the directory containing music files
//     const String customPath = '/storage/emulated/0/Music';
//     final Directory customDir = Directory(customPath);
//     if (await customDir.exists()) {
//       print("Directory found: ${customDir.path}");

//       // List all files in the directory
//       setState(() {
//         _musicFiles = customDir
//             .listSync()
//             .where((file) => file.path.endsWith('.mp3'))
//             .toList();
//       });

//       print("Music files fetched: ${_musicFiles.length}");
//     } else {
//       print("Music directory not found");
//     }
//   }


// }
