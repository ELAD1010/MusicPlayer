import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:music_player/classes/song_object.dart';

class RemoteApi {
  static Future<List<Song>> getCharacterList(
    int offset,
    int limit, {
    String? searchTerm,
  }) async =>
      http
          .get(
            _ApiUrlBuilder.characterList(offset, limit, searchTerm: searchTerm),
          )
          .mapFromResponse<List<Song>, List<dynamic>>(
            (jsonArray) => _parseItemListFromJsonArray(
              jsonArray,
              (jsonObject) => Song.fromJson(jsonObject),
            ),
          );

  static List<T> _parseItemListFromJsonArray<T>(
    List<dynamic> jsonArray,
    T Function(dynamic object) mapper,
  ) =>
      jsonArray.map(mapper).toList();
}

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}

class _ApiUrlBuilder {
  static const _baseUrl = 'http://192.168.1.229:3000/songs/';
  static const _charactersResource = 'search';

  static Uri characterList(
    int offset,
    int limit, {
    String? searchTerm,
  }) =>
      Uri.parse(
        '$_baseUrl$_charactersResource?'
        'offset=$offset'
        '&limit=$limit'
        '${_buildSearchTermQuery(searchTerm)}',
      );

  static String _buildSearchTermQuery(String? searchTerm) =>
      searchTerm != null && searchTerm.isNotEmpty
          ? '&name=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
          : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}
