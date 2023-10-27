import 'dart:developer';

import 'package:flutter/material.dart';

enum Logs { print, debugPrint, logs, hideLogs }

Logs _logs = Logs.debugPrint;

/// ## ColorCodes
///  30. black
///  31. red
///  32. green
///  33. yellow
///  34. blue
///  35. magenta
///  36. cyan
///  37. white
///  90. brightBlack
///  91. brightRed
///  92. brightGreen
///  93. brightYellow
///  94. brightBlue
///  95. brightMagenta
///  96. brightCyan
///  97. brightWhite
class ColoredLog {
  ColoredLog(var message, {String? name}) {
    _customLog(
      message,
      colorCode: 35,
      name: name,
    );
  }
  static _customLog(
    var message, {
    required int colorCode,
    String? name,
  }) {
    if (_logs == Logs.logs) {
      String coloredName =
          "\x1B[${colorCode.toString()}m${name ?? "Log"}\x1B[0m";
      String coloredMessage =
          '\x1B[${colorCode.toString()}m${message.toString()}\x1B[0m';

      log(
        coloredMessage,
        name: coloredName,
      );
    } else if (_logs == Logs.print) {
      String coloredName = "\x1B[37m${name ?? "Log"}\x1B[0m";
      String coloredMessage =
          '\x1B[${colorCode.toString()}m${message.toString()}\x1B[0m';
      // ignore: avoid_print
      print('[$coloredName] $coloredMessage');
    } else if (_logs == Logs.debugPrint) {
      String coloredName = "\x1B[37m${name ?? "Log"}\x1B[0m";
      String coloredMessage =
          '\x1B[${colorCode.toString()}m${message.toString()}\x1B[0m';
      debugPrint('[$coloredName] $coloredMessage');
    }
  }

  static black(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 30,
      name: name,
    );
  }

  static red(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 31,
      name: name,
    );
  }

  static green(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 32,
      name: name,
    );
  }

  static yellow(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 33,
      name: name,
    );
  }

  static blue(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 34,
      name: name,
    );
  }

  static magenta(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 35,
      name: name,
    );
  }

  static cyan(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 36,
      name: name,
    );
  }

  static white(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 37,
      name: name,
    );
  }

  static blackBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 90,
      name: name,
    );
  }

  static redBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 91,
      name: name,
    );
  }

  static greenBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 92,
      name: name,
    );
  }

  static yellowBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 93,
      name: name,
    );
  }

  static blueBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 94,
      name: name,
    );
  }

  static magentaBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 95,
      name: name,
    );
  }

  static cyanBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 96,
      name: name,
    );
  }

  static whiteBright(
    var message, {
    String? name,
  }) {
    _customLog(
      message,
      colorCode: 97,
      name: name,
    );
  }
}
