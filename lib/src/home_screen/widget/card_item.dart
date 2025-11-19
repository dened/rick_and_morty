import 'package:collection/collection.dart';
import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/data_source/models.dart';
import 'package:rick_and_morty/src/home_screen/controller/favorites_list_controller.dart';
import 'package:ui/ui.dart';

/// {@template card_item}
/// CardItem widget.
/// {@endtemplate}
class CardItem extends StatefulWidget {
  /// {@macro card_item}
  const CardItem({
    required this.character,
    super.key, // ignore: unus
    this.onTap,
  });

  final VoidCallback? onTap;
  final Character character;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _isPressed = false;

  void _onPressed(bool pressed) {
    if (_isPressed == pressed) return;
    setState(() {
      _isPressed = pressed;
    });
  }

  Color _borderColor(BuildContext context) =>
      _isPressed ? Theme.of(context).custom.ring : Theme.of(context).custom.border;

  @override
  Widget build(BuildContext context) => HoverScaleTransitionWrapper(
    scale: 1.02,
    child: Card.outlined(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _borderColor(context), width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (_) => _onPressed(true),
        onTapUp: (_) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Ink(
                    padding: const EdgeInsets.all(60),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      image: DecorationImage(image: NetworkImage(widget.character.image), fit: BoxFit.cover),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: <Widget>[
                      AppText.titleMedium(widget.character.name),
                      StatusWidget(
                        status: widget.character.status == CharacterStatus.alive ? Status.alive : Status.dead,
                      ),
                      AppText.labelLarge(widget.character.species),
                      AppText.labelMedium(widget.character.origin.name),
                    ],
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ValueListenableBuilder(
                  valueListenable: context.controllerOf<FavoritesListController>().select(
                    (state) => state.characters.firstWhereOrNull((it) => it.id == widget.character.id) != null,
                  ),
                  builder: (context, value, _) => FavoriteItemListIcon(
                    value: value,
                    onChanged: (value) {
                      if (value) {
                        context.controllerOf<FavoritesListController>().addFavorite(widget.character);
                      } else {
                        context.controllerOf<FavoritesListController>().removeFavorite(widget.character);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

enum Status { alive, dead, unknown }

/// {@template card_item}
/// StatusWidget widget.
/// {@endtemplate}
class StatusWidget extends StatelessWidget {
  /// {@macro card_item}
  const StatusWidget({
    required this.status,
    super.key, // ignore: unused_element
  });

  final Status status;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: status == Status.alive
          ? Theme.of(context).colorScheme.primary.withAlpha(100)
          : Theme.of(context).colorScheme.error.withAlpha(100),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: AppText.labelMedium(status == Status.alive ? 'Alive' : 'Dead'),
    ),
  );
}

class CardItemSkeleton extends StatelessWidget {
  const CardItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Card.outlined(
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Theme.of(context).custom.border, width: 3),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(aspectRatio: 1, child: Shimmer()),

        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: <Widget>[
              Shimmer(size: Size(150, 22), radius: Radius.circular(4)),
              Shimmer(size: Size(50, 18), radius: Radius.circular(8)),
              Shimmer(size: Size(100, 16), radius: Radius.circular(4)),
            ],
          ),
        ),
      ],
    ),
  );
}
