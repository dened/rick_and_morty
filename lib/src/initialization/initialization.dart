import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';
import 'package:rick_and_morty/src/app.dart';
import 'package:rick_and_morty/src/initialization/initialize_dependecies.dart' as init;

Future<void> initializeApp() async {
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  try {
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      l.e('Top level error: $error', stackTrace);
      return true;
    };

    final dependencies = await init.initializeDependencies();
    l.v6('Dependencies initialized');

    SchedulerBinding.instance.addPostFrameCallback((callback) {
      binding.allowFirstFrame();
    });

    runApp(dependencies.inject(child: const App()));
  } on Object catch (error, stackTrace) {
    l.e('Top level error: $error', stackTrace);
    binding.allowFirstFrame();
    runApp(ErrorWidget(error));
  }
}
// 'C:\ProgramData\chocolatey\lib\visualstudio2019-workload-vctools\tools\ChocolateyInstall.ps1