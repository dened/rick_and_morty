import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/auth/gogle_auth_page.dart';

/// {@template app}
/// App widget.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: 'Material App',
    home: SignInDemo(),
    //   home: Scaffold(
    //     appBar: AppBar(title: const Text('Material App Bar')),
    //     body: const SafeArea(
    //       child: Column(
    //         children: [
    //           Center(child: Text('Hello World')),

    //           ElevatedButton(onPressed: signInWithGoogle, child: Text('Button')),
    //         ],
    //       ),
    //     ),
    //   ),
  );
}
