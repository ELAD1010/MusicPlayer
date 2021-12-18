import "package:flutter/material.dart";
import 'package:audioplayers/audioplayers.dart';
import 'package:music_player/classes/song_object.dart';
import "package:http/http.dart" as http;
import 'package:music_player/utils/save_audio.dart';
import 'package:music_player/widgets/download_button.dart';
import 'package:music_player/widgets/download_finished_icon.dart';
import 'package:music_player/widgets/pause_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../widgets/song_image.dart';
import '../widgets/song_title.dart';
import "../widgets/play_button.dart";
import "../widgets/previous_button.dart";
import "../widgets/next_button.dart";

class MusicPlayer extends StatefulWidget {
  final Song? song;

  const MusicPlayer({Key? key, this.song}) : super(key: key);

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  Duration duration = Duration(seconds: 0);
  Duration position = Duration(seconds: 0);
  bool isDownloading = false;
  bool wasDownloaded = false;
  double progress = 0;
  Storage? storage;
  bool isPlaying = false;

  AudioPlayer audioPlayer = AudioPlayer();

  void initState() {
    super.initState();
    initPlayer();
    storage = Storage(downloadProgress);
  }

  void initPlayer() {
    setState(() {
      isPlaying = true;
    });
    play();
    audioPlayer.onDurationChanged.listen((Duration d) => setState(() {
          duration = d;
        }));
    audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
          position = p;
        }));
  }

  void play() async {
    final song = widget.song;
    String directory = (await getApplicationDocumentsDirectory()).path;
    String songName = song!.title.replaceAll('/', '-');
    String path = '$directory/$songName.mp3';
    File file = File(path);
    if (await file.exists()) {
      await audioPlayer.play(file.path, isLocal: true);
      setState(() {
        wasDownloaded = true;
      });
    } else {
      setState(() {
        wasDownloaded = false;
      });
      await audioPlayer.play(
          'http://192.168.1.229:3000/songs/play?url=${song!.url}',
          isLocal: true);
    }
  }

  void pause() async {
    audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void resume() async {
    audioPlayer.resume();
    setState(() {
      isPlaying = true;
    });
  }

  void downloadProgress(received, total) {
    print("hello");
    if (total != -1) {
      progress = received / total;
      setState(() {
        progress;
      });
      if (progress == 1.0) {
        setState(() {
          progress = 0;
          wasDownloaded = true;
          isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.song;
    return Scaffold(
      body: song != null
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: NetworkImage(
                    song.thumbnail,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SongImage(imageUrl: song.thumbnail),
                  const SizedBox(height: 10),
                  SongTitle(
                    title: song.title,
                    subtitle: song.artist,
                  ),
                  Slider(
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey,
                    value: position.inMilliseconds.toDouble(),
                    onChanged: (double value) async => await audioPlayer
                        .seek(Duration(milliseconds: value.toInt())),
                    min: 0.0,
                    max: duration.inMilliseconds.toDouble(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 18),
                          child: Text(
                            position.toString().substring(3, 7),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )),
                      Container(
                          padding: const EdgeInsets.only(right: 18),
                          child: Text(
                            duration.toString().substring(3, 7),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isDownloading
                          ? CircularProgressIndicator(
                              strokeWidth: 4, value: progress)
                          : Container(
                              margin: EdgeInsets.only(right: 2, top: 6),
                              child: wasDownloaded
                                  ? const DownloadFinishedIcon()
                                  : DownloadButton(downloadSong: () {
                                      setState(() {
                                        isDownloading = true;
                                        wasDownloaded = false;
                                        progress = 0;
                                      });
                                      storage!.writeSongToAppDir(
                                          'http://192.168.1.229:3000/songs/download?url=${song!.url}',
                                          song!.title);
                                    }),
                            ),
                      const PreviousButton(),
                      isPlaying ? PauseButton(pause) : PlayButton(resume),
                      const NextButton(),
                    ],
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }
}
