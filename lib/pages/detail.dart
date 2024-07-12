// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:musicc/main.dart';
import 'package:musicc/pages/songs.dart';

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
  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();

    widget.audioPlayer.onPositionChanged.listen((positionValue) {
      setState(() {
        position = positionValue;
      });
    });

    widget.audioPlayer.onDurationChanged.listen((durationValue) {
      setState(() {
        duration = durationValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxSliderValue = duration.inSeconds.toDouble();

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
            Slider(
              value: position.inSeconds.toDouble().clamp(0.0, maxSliderValue),
              min: 0.0,
              max: maxSliderValue,
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await widget.audioPlayer.seek(newPosition);
                print(newPosition);
              },
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     //Pause_Play.previousMusic(context, widget.index, () {
                  //       //setState(() {});
                  //     });
                  //   },
                  //   child: Icon(Icons.skip_previous_rounded),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      await Pause_Play.playerr(context, widget.index, () {
                        setState(() {});
                      });
                    },
                    child: Pause_Play.choose(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Pause_Play.nextMusic(context, widget.index, () {
                        setState(() {});
                      });
                    },
                    child: Icon(Icons.skip_next_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
