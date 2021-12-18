import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import "package:http/http.dart" as http;
import 'package:dio/dio.dart';

class Storage {
  // double _progress = 0;
  // bool isFinished = false;
  // bool isDownloading = false;
  final Function downloadProgress;

  Storage(this.downloadProgress);

  Future<File> _localFile(String songName) async {
    final path = await _localPath;
    return File('$path/$songName.mp3');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // get downloadProgress => _progress;

  writeSongToAppDir(String url, String songName) async {
    // isDownloading = true;
    // isFinished = false;
    // _progress = 0;
    // notifyListeners();
    print('gh');
    final file = await _localFile(songName);
    // Write the file
    Dio dio = Dio();
    dio.download(
      url,
      file.path,
      onReceiveProgress: (received, total) {
        downloadProgress(received, total);
        // if (total != -1) {
        //   _progress = received / total;
        //   if (_progress == 1.0) {
        //     print(_progress);
        //     _progress = 0;
        //     isFinished = true;
        //     isDownloading = false;
        //   }
        //   notifyListeners();
        // }
      },
    );

    // await file.writeAsBytes(response.bodyBytes, flush: true);

    // print(file.uri);

    // return file.uri;
  }

  Future<dynamic> readSongData(String songName) async {
    try {
      final file = await _localFile(songName);

      // Read the file
      Uint8List songBytes = await file.readAsBytes();

      return songBytes;
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
}
