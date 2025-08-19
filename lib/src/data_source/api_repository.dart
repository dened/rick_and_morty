import 'dart:convert';
import 'dart:io';

import 'package:rick_and_morty/src/data_source/models.dart';

abstract interface class IApiRepository {
  Future<CharacterResponse> getCharacters({required int page});
}

class ApiRepository implements IApiRepository {
  ApiRepository(this._client);

  final HttpClient _client;

  @override
  Future<CharacterResponse> getCharacters({required int page}) => _client
      .getUrl(Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'))
      .then((response) => response.close())
      .then((responseBody) => responseBody.transform(utf8.decoder).join())
      .then<Map<String, dynamic>>((jsonString) => json.decode(jsonString) as Map<String, dynamic>)
      .then(CharacterResponse.fromJson);
}
