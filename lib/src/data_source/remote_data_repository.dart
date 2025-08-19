import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class RemoteDataRepository {
  Future<void> addToFavorite(String uid, int value);
  Future<void> removeFromFavorite(String uid, int value);
  Future<bool> isFavorite(String uid, int value);
  Future<List<int>> getFavorites(String uid);
}

class RemoteDataRepositoryImpl implements RemoteDataRepository {
  RemoteDataRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  /// Returns a reference to the `favorites` collection for the current user.
  /// Returns `null` if the user is not authenticated.
  CollectionReference<Map<String, dynamic>>? _favoritesCollection(String uid) =>
      _firestore.collection('users').doc(uid).collection('favorites');

  @override
  Future<void> addToFavorite(String uid, int value) async {
    final collection = _favoritesCollection(uid);
    if (collection == null) throw StateError('User not authenticated to add favorite.');
    // Мы используем ID персонажа как ID документа, чтобы избежать дубликатов
    // и сделать поиск более эффективным.
    await collection.doc(value.toString()).set({'id': value});
  }

  @override
  Future<List<int>> getFavorites(String uid) async {
    final collection = _favoritesCollection(uid);
    if (collection == null) return []; // Возвращаем пустой список, если пользователь не вошел в систему
    final snapshot = await collection.get();
    return snapshot.docs.map((e) => e.data()['id'] as int).toList();
  }

  @override
  Future<bool> isFavorite(String uid, int value) async {
    final collection = _favoritesCollection(uid);
    if (collection == null) return false;
    // Прямой поиск документа намного эффективнее, чем запрос.
    final doc = await collection.doc(value.toString()).get();
    return doc.exists;
  }

  @override
  Future<void> removeFromFavorite(String uid, int value) async {
    final collection = _favoritesCollection(uid);
    if (collection == null) return;
    await collection.doc(value.toString()).delete();
  }
}
