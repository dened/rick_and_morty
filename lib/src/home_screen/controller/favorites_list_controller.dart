import 'package:control/control.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/data_source/favorites_repository.dart';
import 'package:rick_and_morty/src/data_source/models.dart';

/// {@template favorites_list_state}
/// FavoritesListState.
/// {@endtemplate}
sealed class FavoritesListState extends _$FavoritesListStateBase {
  /// {@macro favorites_list_state}
  const FavoritesListState({required super.characters, required super.message});

  /// Idle
  /// {@macro favorites_list_state}
  const factory FavoritesListState.idle({required List<Character> characters, String message}) =
      FavoritesListState$Idle;

  /// Processing
  /// {@macro favorites_list_state}
  const factory FavoritesListState.processing({required List<Character> characters, String message}) =
      FavoritesListState$Processing;

  /// Failed
  /// {@macro favorites_list_state}
  const factory FavoritesListState.failed({required List<Character> characters, String message}) =
      FavoritesListState$Failed;
}

/// Idle
final class FavoritesListState$Idle extends FavoritesListState {
  const FavoritesListState$Idle({required super.characters, super.message = 'Idle'});
}

/// Processing
final class FavoritesListState$Processing extends FavoritesListState {
  const FavoritesListState$Processing({required super.characters, super.message = 'Processing'});
}

/// Failed
final class FavoritesListState$Failed extends FavoritesListState {
  const FavoritesListState$Failed({required super.characters, super.message = 'Failed'});
}

@immutable
abstract base class _$FavoritesListStateBase {
  const _$FavoritesListStateBase({required this.characters, required this.message});

  /// Data entity payload.
  @nonVirtual
  final List<Character> characters;

  /// Message or description.
  @nonVirtual
  final String message;

  /// Check if is Idle.
  bool get isIdle => this is FavoritesListState$Idle;

  /// Check if is Processing.
  bool get isProcessing => this is FavoritesListState$Processing;

  /// Check if is Failed.
  bool get isFailed => this is FavoritesListState$Failed;

  @override
  int get hashCode => characters.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _$FavoritesListStateBase &&
          runtimeType == other.runtimeType &&
          identical(characters, other.characters));

  @override
  String toString() => 'FavoritesListState{message: $message}';
}

final class FavoritesListController extends StateController<FavoritesListState> with SequentialConrollerHandler {
  FavoritesListController({required IFavoritesRepository repository})
    : _repository = repository,
      super(
        initialState: const FavoritesListState.idle(characters: [], message: 'Idle'),
      );

  final IFavoritesRepository _repository;

  Future<void> getFavorites() => handle(() async {
    setState(FavoritesListState.processing(characters: state.characters, message: 'Fetch favotires...'));
    final result = await _repository.fetchFavorites();
    setState(FavoritesListState.idle(characters: result, message: 'Favorites is updated.'));
  });

  Future<void> removeFavorite(Character character) => handle(() async {
    setState(
      FavoritesListState.processing(characters: [...state.characters..removeWhere((it) => it.id == character.id)]),
    );
    final result = await _repository.removeFavorite(character);
    setState(FavoritesListState.idle(characters: state.characters, message: 'Favorites is updated.'));
  });

  Future<void> addFavorite(Character character) => handle(() async {
    setState(
      FavoritesListState.processing(characters: [...state.characters, character]),
    );
    final result = await _repository.addFavorite(character);
    setState(FavoritesListState.idle(characters: state.characters, message: 'Favorites is updated.'));
  });
}


