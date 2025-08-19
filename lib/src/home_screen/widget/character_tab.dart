import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/data_source/api_repository.dart';
import 'package:rick_and_morty/src/data_source/models.dart';
import 'package:rick_and_morty/src/initialization/dependencies.dart';
import 'package:ui/ui.dart';

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
  late final IApiRepository repository;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
    repository = Dependencies.of(context).apiRepository;
  }

  @override
  void didUpdateWidget(covariant CharacterTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => FutureBuilder<CharacterResponse>(
    future: repository.getCharacters(page: 1),
    builder: (context, data) {
      if (data.hasError) {
        return Text(data.error?.toString() ?? 'error');
      }

      if (data.hasData) {
        final results = data.data!.results;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,

            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final result = results[index];
            return CardItem(
              imageUrl: result.image,
              name: result.name,
              status: result.status == CharacterStatus.alive ? Status.alive : Status.dead,
              species: result.species,
              location: result.location.name,
            );
          },
          itemCount: results.length,
        );
      }

      return const Center(child: CircularProgressIndicator());
    },
  );
}
