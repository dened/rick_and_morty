import 'package:control/control.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/src/_core/adaptive_content_list_widget.dart';
import 'package:rick_and_morty/src/home_screen/controller/favorites_list_controller.dart';
import 'package:rick_and_morty/src/home_screen/widget/card_item.dart';
import 'package:ui/ui.dart';

class FavoritesString {
  static const String noFavoritesTitle = 'No favorites yet';
  static const String noFavoritesMessage = 'Add some characters to your favorites list! \nPress ❤️ in list';
}

/// {@template favorites_tab}
/// FavoritesTab widget.
/// {@endtemplate}
class FavoritesTab extends StatefulWidget {
  /// {@macro favorites_tab}
  const FavoritesTab({
    super.key, // ignore: unused_element
  });

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

/// State for widget FavoritesTab.
class _FavoritesTabState extends State<FavoritesTab> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FavoritesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  /* #endregion */

  @override
  Widget build(BuildContext context) => StateConsumer<FavoritesListController, FavoritesListState>(
    builder: (context, state, child) {
      if (state.characters.isEmpty) return const EmptyFavoritesWidget();

      return AdaptiveContentListWidget(
        itemBuilder: (context, index) {
          final result = state.characters[index];
          return CardItem(character: result);
        },
        itemCount: state.characters.length,
      );
    },
  );
}

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          BrokenHeartWidget(),
          AppText.headlineMedium(FavoritesString.noFavoritesTitle),
          SizedBox(height: 16),
          AppText.bodyLarge(FavoritesString.noFavoritesMessage, maxLines: 4),
        ],
      ),
    ),
  );
}
