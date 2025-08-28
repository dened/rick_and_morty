import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:rick_and_morty/src/_core/adaptive_content_list_widget.dart';
import 'package:rick_and_morty/src/home_screen/controller/character_list_controller.dart';
import 'package:rick_and_morty/src/home_screen/widget/card_item.dart';

/// Observer for [Controller], react to changes in the any controller.
final class ControllerObserver implements IControlObserver {
  const ControllerObserver();

  @override
  void onCreate(Controller controller) {
    l.v6('Controller | ${controller.runtimeType}.new');
  }

  @override
  void onDispose(Controller controller) {
    l.v5('Controller | ${controller.runtimeType}.dispose');
  }

  @override
  void onStateChanged<S extends Object>(StateController<S> controller, S prevState, S nextState) {
    l.d(
      'StateController | '
      '${controller.runtimeType.toString()} | '
      '$prevState -> $nextState',
    );
  }

  @override
  void onError(Controller controller, Object error, StackTrace stackTrace) {
    l.w(
      'Controller | '
      '${controller.runtimeType} | '
      '$error',
      stackTrace,
    );
  }

  @override
  void onHandler(Object context) {
    // TODO: implement onHandle
  }
}

/// {@template character_tab}
/// CharacterTab widget.
/// {@endtemplate}
class CharacterTab extends StatefulWidget {
  /// {@macro character_tab}
  const CharacterTab({
    super.key, // ignore: unused_element
  });

  @override
  State<CharacterTab> createState() => _CharacterTabState();
}

/// State for widget CharacterTab.
class _CharacterTabState extends State<CharacterTab> {
  final _scrollController = ScrollController();
  late final CharacterListController _characterListController;

  @override
  void initState() {
    super.initState();
    Controller.observer = const ControllerObserver();
    _characterListController = context.controllerOf<CharacterListController>();
    _characterListController.fetchCharacters();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 500) {
      _characterListController.fetchCharacters();
    }
  }

  Future<void> _onRefresh() async => _characterListController.fetchCharacters(refresh: true);

  @override
  Widget build(BuildContext context) => StateConsumer<CharacterListController, CharacterListState>(
    builder: (context, state, child) {
      if (state.isFailed && !state.hasData) {
        return const Center(child: Text('error'));
      }

      if (!state.hasData) {
        return const Center(child: CircularProgressIndicator());
      }

      final results = state.characters!;
      final hasReachedMax = !state.cursor.hasMore;

      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: AdaptiveContentListWidget(
          itemBuilder: (context, index) {
            if (index >= results.length) {
              return const CardItemSkeleton();
            }
            final result = results[index];
            return CardItem(character: result);
          },
          itemCount: hasReachedMax ? results.length : results.length + (state.isProcessing ? 10 : 0),
          onReachEndOfList: () => _characterListController.fetchCharacters(),
        ),
      );
    },
  );
}
