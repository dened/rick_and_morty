import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rick_and_morty/src/auth/web_wrapper.dart' as web;

/// {@template login_page}
/// LoginPage widget.
/// {@endtemplate}
class LoginPage extends StatefulWidget {
  /// {@macro login_page}
  const LoginPage({
    super.key, // ignore: unused_element
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// State for widget LoginPage.
class _LoginPageState extends State<LoginPage> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant LoginPage oldWidget) {
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Column(
      children: [
        if (GoogleSignIn.instance.supportsAuthenticate())
          ElevatedButton(
            onPressed: () async {
                await GoogleSignIn.instance.authenticate();

            },
            child: const Text('SIGN IN'),
          )
        else ...<Widget>[
          if (kIsWeb)
            web.renderButton()
          // #enddocregion ExplicitSignIn
          else
            const Text('This platform does not have a known authentication method'),
        ],
      ],
    ),
  );
}
