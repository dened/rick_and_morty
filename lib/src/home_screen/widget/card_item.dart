import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// {@template card_item}
/// CardItem widget.
/// {@endtemplate}
class CardItem extends StatefulWidget {
  /// {@macro card_item}
  const CardItem({
    super.key, // ignore: unus
    this.onTap,
    this.imageUrl = 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    this.name = 'Rick Sanchez',
    this.status = Status.alive,
    this.species = 'Human',
    this.location = 'Earth (C-137)', // ignore: unused_element
  });

  final VoidCallback? onTap;
  final String imageUrl;
  final String name;
  final Status status;
  final String species;
  final String location;

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
                      image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
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
                      AppText.titleMedium(widget.name),
                      StatusWidget(status: widget.status),
                      AppText.labelLarge(widget.species),
                      AppText.labelMedium(widget.location),
                    ],
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FavoriteItemListIcon(value: true, onChanged: (_) {}),
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
