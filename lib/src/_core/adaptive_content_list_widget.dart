import 'package:flutter/material.dart';

/// {@template adaptive_content_list_widget}
/// AdaptiveContentListWidget widget.
/// {@endtemplate}
class AdaptiveContentListWidget extends StatefulWidget {
  /// {@macro adaptive_content_list_widget}
  const AdaptiveContentListWidget({
    required this.itemBuilder,
    super.key,
    this.itemCount,
    this.onReachEndOfList, // ignore: unused_element
  });

  final NullableIndexedWidgetBuilder itemBuilder;
  final VoidCallback? onReachEndOfList;
  final int? itemCount;

  @override
  State<AdaptiveContentListWidget> createState() => _AdaptiveContentListWidgetState();
}

/// State for widget AdaptiveContentListWidget.
class _AdaptiveContentListWidgetState extends State<AdaptiveContentListWidget> {
  late final ScrollController _scrollController;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 500) {
      widget.onReachEndOfList?.call();
    }
  }

  @override
  void didUpdateWidget(covariant AdaptiveContentListWidget oldWidget) {
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
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: _scrollController,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1024),
        child: CustomScrollView(
          controller: _scrollController,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),

          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _columntCount(context),
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: widget.itemBuilder,
                itemCount: widget.itemCount,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  int _columntCount(BuildContext context) => switch (MediaQuery.of(context).size.width) {
    >= 1024 => 5,
    >= 768 => 4,
    <= 600 => 2,
    _ => 3,
  };
}
