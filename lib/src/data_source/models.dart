import 'package:meta/meta.dart';

@immutable
class CharacterResponse {
  const CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) => CharacterResponse(
    info: Info.fromJson(json['info'] as Map<String, dynamic>),
    results: (json['results'] as List<dynamic>).map((e) => Character.fromJson(e as Map<String, dynamic>)).toList(),
  );

  final Info info;
  final List<Character> results;
}

@immutable
class Info {
  const Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json['count'] as int,
    pages: json['pages'] as int,
    next: json['next'] as String?,
    prev: json['prev'] as String?,
  );

  final int count;
  final int pages;
  final String? next;
  final String? prev;
}

enum CharacterStatus {
  alive,
  dead,
  unknown;

  factory CharacterStatus.fromString(String value) =>
      CharacterStatus.values.firstWhere((e) => e.name == value.toLowerCase(), orElse: () => CharacterStatus.unknown);
}

enum CharacterGender {
  female,
  male,
  genderless,
  unknown;

  factory CharacterGender.fromString(String value) =>
      CharacterGender.values.firstWhere((e) => e.name == value.toLowerCase(), orElse: () => CharacterGender.unknown);
}

@immutable
class Character {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json['id'] as int,
    name: json['name'] as String,
    status: CharacterStatus.fromString(json['status'] as String),
    species: json['species'] as String,
    type: json['type'] as String,
    gender: CharacterGender.fromString(json['gender'] as String),
    origin: LocationInfo.fromJson(json['origin'] as Map<String, dynamic>),
    location: LocationInfo.fromJson(json['location'] as Map<String, dynamic>),
    image: json['image'] as String,
    episode: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
    url: json['url'] as String,
    created: DateTime.parse(json['created'] as String),
  );

  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final LocationInfo origin;
  final LocationInfo location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;
}

@immutable
class LocationInfo {
  const LocationInfo({required this.name, required this.url});

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      LocationInfo(name: json['name'] as String, url: json['url'] as String);

  final String name;
  final String url;
}
