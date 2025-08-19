import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, themeMode});

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeMode,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: value,
          home: MyHomePage(title: 'Flutter Demo Home Page', themeMode: themeMode),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.themeMode});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final ValueNotifier<ThemeMode> themeMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          ValueListenableBuilder(
            valueListenable: widget.themeMode,
            builder: (context, value, child) {
              return Switch.adaptive(
                value: ThemeMode.light == value,
                onChanged: (value) {
                  widget.themeMode.value = value ? ThemeMode.light : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1024),
            child: CustomScrollView(
              controller: _scrollController,
              scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              slivers: [
                SliverList.list(
                  children: [
                    AppText.displayLarge('Display Large (57pt / w400'),
                    AppText.displayMedium('Display Medium (45pt / w400'),
                    AppText.displaySmall('Display Small (36pt / w400'),
                    AppText.headlineLarge('Headline Large (32pt / w400)'),
                    AppText.headlineMedium('Headline Medium (32pt / w400'),
                    AppText.headlineSmall('Headline Small (24pt / w400'),
                    AppText.titleLarge('Title Large (22pt / w700)'),
                    AppText.titleMedium('Title Medium (16pt / w700)'),
                    AppText.titleSmall('Title Small (14pt / w700)'),
                    AppText.bodyLarge('Body Large (16pt / w400)'),
                    AppText.bodyMedium('Body Medium (14pt / w400)'),
                    AppText.bodySmall('Body Small (12pt / w400)'),
                    AppText.labelLarge('Label Large (14pt / w400)'),
                    AppText.labelMedium('Label Medium (12pt / w400)'),
                    AppText.labelSmall('Label Small (11pt / w400)'),

                    SizedBox(height: 32),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(child: CardItem(onTap: () => debugPrint('Card tapped.'))),

                        Expanded(child: CardItem(status: Status.dead)),
                      ],
                    ),
                  ],
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columntCount(context),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.6,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CardItem(status: index % 3 == 0 ? Status.alive : Status.dead);
                    }, childCount: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int columntCount(BuildContext context) {
    return switch (MediaQuery.of(context).size.width) {
      >= 1024 => 6,
      >= 768 => 4,
      <= 600 => 2,
      _ => 3,
    };
  }
}
