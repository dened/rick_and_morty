import 'dart:async';

import 'package:intl/intl.dart';
import 'package:l/l.dart';
import 'package:rick_and_morty/src/initialization/initialization.dart' as init;

void main() {
  l.capture<void>(
    () => runZonedGuarded(() async {
      init.initializeApp().ignore();
      
    }, l.e),
    const LogOptions(
      handlePrint: true,
      overrideOutput: _messageFormatting,
      outputInRelease: false,
      output: LogOutput.print,
      printColors: true,
    ),
  );
}

String? _messageFormatting(LogMessage event) {
  var message = switch (event.message) {
    // Convert message to string.
    String text => text,
    Object obj => obj.toString(),
  };

  return '[${event.level.prefix}] '
      '${DateFormat('dd.MM.yyyy HH:mm:ss').format(event.timestamp)} '
      '| $message';
}
