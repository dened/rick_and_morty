import 'package:rick_and_morty/src/data_source/models.dart';

abstract interface class IFavoritesRepository {
  Future<List<Character>> fetchFavorites();
  Future<void> addFavorite(Character character);
  Future<void> removeFavorite(Character character);
}

final class FavoritesRepositoryInMemory implements IFavoritesRepository {
  final List<Character> _favorites = [];

  @override
  Future<List<Character>> fetchFavorites() async => Future.value(List.of(_favorites));

  @override
  Future<void> addFavorite(Character character) async {
    if (!_favorites.any((fav) => fav.id == character.id)) {
      _favorites.add(character);
    }
  }

  @override
  Future<void> removeFavorite(Character character) async {
    _favorites.removeWhere((fav) => fav.id == character.id);
  }
}
