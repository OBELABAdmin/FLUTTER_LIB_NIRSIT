import 'package:logger/logger.dart';

class AppLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;

    if (event.level == Level.error) {
      return [color!('$emoji $message')];
    } else if (event.level == Level.warning) {
      return [color!('$emoji $message')];
    }
    return [color!(message)];
  }
}
