// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
  Duration _duration = Duration();
  Duration _position = Duration();

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    // set a callback for changing duration
    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
      print('wwwwwwwwwwwww $_duration');
    });
    player.getDuration().then((value) async {
      _duration = value!;
    });
    // set a callback for position change
    player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
      // print('pppppppppppppppp $_position');
    });

    player.onPlayerComplete.listen((_) {
      setState(() => _position = _duration);
    });
  }

  @override
  Widget build(BuildContext context) {
    double cc = _duration.inSeconds.toDouble();
    double dd = _position.inSeconds.toDouble();
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
                color: Color.fromARGB(255, 253, 249, 249),
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
              value: _position.inSeconds.toDouble(),
              onChanged: (value) async {
                await player.seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
              min: 0,
              max: cc > 0 ? cc : 3,
              inactiveColor: Colors.grey,
              activeColor: Colors.red,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(dd.toStringAsFixed(2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      int index = widget.index - 1;
                      Pause_Play.playerr(context, index, () {
                        setState(() {}); // Update the state to rebuild the UI
                      });
                    },
                    child: Icon(Icons.skip_previous_rounded)),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Pause_Play.playerr(context, widget.index, () {
                      setState(() {}); // Update the state to rebuild the UI
                    });
                  },
                  child: Pause_Play.choose(),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      int index = widget.index + 1;
                      Pause_Play.playerr(context, index, () {
                        setState(() {}); // Update the state to rebuild the UI
                      });
                    },
                    child: Icon(Icons.skip_next_rounded))
              ],
            )
          ],
        ),
      ),
    );
  }
}
