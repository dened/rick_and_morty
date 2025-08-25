import 'package:control/control.dart';
import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:rick_and_morty/src/data_source/api_repository.dart';
import 'package:rick_and_morty/src/data_source/models.dart';

class CharacterListCursor {
  const CharacterListCursor({required this.page, required this.prev, required this.next});
  final int page;
  final String? prev;
  final String? next;

  bool get hasMore => next != null;

  CharacterListCursor copyWith({int? page, String? prev, String? next}) =>
      CharacterListCursor(page: page ?? this.page, prev: prev ?? this.prev, next: next ?? this.next);
}

/// {@template character_list_controller_state}
/// CharacterListState.
/// {@endtemplate}
sealed class CharacterListState extends _$CharacterListStateBase {
  /// {@macro character_list_controller_state}
  const CharacterListState({required super.characters, required super.cursor, required super.message});

  /// Idle
  /// {@macro character_list_controller_state}
  const factory CharacterListState.idle({
    required CharacterListCursor cursor,
    List<Character>? characters,
    String message,
  }) = CharacterListState$Idle;

  /// Processing
  /// {@macro character_list_controller_state}
  const factory CharacterListState.processing({
    required CharacterListCursor cursor,
    List<Character>? characters,
    String message,
  }) = CharacterListState$Processing;

  /// Failed
  /// {@macro character_list_controller_state}
  const factory CharacterListState.failed({
    required CharacterListCursor cursor,
    List<Character>? characters,
    String message,
  }) = CharacterListState$Failed;

  /// Initial
  /// {@macro character_list_controller_state}
  factory CharacterListState.initial({
    required CharacterListCursor cursor,
    List<Character>? characters,
    String? message,
  }) => CharacterListState$Idle(characters: characters, cursor: cursor, message: message ?? 'Initial');
}

/// Idle
final class CharacterListState$Idle extends CharacterListState {
  const CharacterListState$Idle({required super.cursor, super.characters, super.message = 'Idle'});

  @override
  String get type => 'idle';
}

/// Processing
final class CharacterListState$Processing extends CharacterListState {
  const CharacterListState$Processing({required super.cursor, super.characters, super.message = 'Processing'});

  @override
  String get type => 'processing';
}

/// Failed
final class CharacterListState$Failed extends CharacterListState {
  const CharacterListState$Failed({required super.cursor, super.characters, super.message = 'Failed'});

  @override
  String get type => 'failed';
}

/// Pattern matching for [CharacterListState].
typedef CharacterListStateMatch<R, S extends CharacterListState> = R Function(S element);

@immutable
abstract base class _$CharacterListStateBase {
  const _$CharacterListStateBase({required this.characters, required this.cursor, required this.message});

  /// Type alias for [CharacterListState].
  abstract final String type;

  @nonVirtual
  final List<Character>? characters;

  @nonVirtual
  final CharacterListCursor cursor;

  /// Message or description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => characters != null;

  /// Check if is Idle.
  bool get isIdle => this is CharacterListState$Idle;

  /// Check if is Processing.
  bool get isProcessing => this is CharacterListState$Processing;

  /// Check if is Failed.
  bool get isFailed => this is CharacterListState$Failed;

  @override
  int get hashCode => Object.hash(type, characters, cursor);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _$CharacterListStateBase &&
          type == other.type &&
          identical(characters, other.characters) &&
          identical(cursor, other.cursor));

  @override
  String toString() => 'CharacterListState.$type{message: $message}';
}

final class CharacterListController extends StateController<CharacterListState> with SequentialConrollerHandler {
  CharacterListController({
    required IApiRepository repository,
    super.initialState = const CharacterListState.idle(
      characters: [],
      cursor: CharacterListCursor(page: 1, prev: null, next: ''),
      message: 'Initial',
    ),
  }) : _apiRepository = repository;

  final IApiRepository _apiRepository;

  Future<void> fetchCharacters({bool refresh = false}) {
    if (!refresh && (!state.isIdle || !state.cursor.hasMore)) return Future.value();

    return handle(() async {
      if (refresh) {
        l.i('Refresching characters list...');
        setState(CharacterListState.processing(characters: state.characters, cursor: state.cursor));
        const newCursor = CharacterListCursor(page: 1, prev: null, next: null);
        final characters = await _apiRepository.getCharacters(page: newCursor.page);
        setState(
          CharacterListState.idle(
            characters: characters.results,
            cursor: newCursor.copyWith(next: characters.info.next, prev: characters.info.prev),
          ),
        );
      } else {
        l.i('Fetching characters list...');
        setState(CharacterListState.processing(characters: state.characters, cursor: state.cursor));
        final characters = await _apiRepository.getCharacters(page: state.cursor.page);

        setState(
          CharacterListState.idle(
            characters: [...state.characters ?? [], ...characters.results],
            cursor: state.cursor.copyWith(page: state.cursor.page + 1, next: characters.info.next, prev: characters.info.prev),
          ),
        );
      }
    });
  }
}
