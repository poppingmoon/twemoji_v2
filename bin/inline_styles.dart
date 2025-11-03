import 'dart:io';

import 'package:xml/xml.dart';

Map<String, Map<String, String>> parseStyle(String input) {
  return Map.fromEntries(
    RegExp(r'\.(\w+)\s*\{([^}]*)\}')
        .allMatches(input)
        .map(
          (match) => MapEntry(
            match[1]!,
            Map.fromEntries(
              match[2]!.split(";").map((decl) {
                if (decl.split(":") case [final key, final value]) {
                  return MapEntry(key.trim(), value.trim());
                }
                return null;
              }).nonNulls,
            ),
          ),
        ),
  );
}

Future<void> main() async {
  final assets = Directory('assets/svg');
  await for (final file in assets.list()) {
    if (file is! File) continue;
    final text = await file.readAsString();
    if (!text.contains('<style>')) continue;
    final document = XmlDocument.parse(text);
    final svg = document.getElement("svg");
    if (svg == null) continue;
    final styles = <String, Map<String, String>>{};
    for (final element in svg.childElements) {
      switch (element.name.local) {
        case "defs":
          if (element.getElement("style") case final style?) {
            styles.addAll(parseStyle(style.innerText));
            style.remove();
          }
        case "path":
          final class_ = element.getAttribute("class");
          if (styles[class_] case final style?) {
            element.removeAttribute("class");
            for (final entry in style.entries) {
              element.setAttribute(entry.key, entry.value);
            }
          }
      }
    }
    if (svg.getElement("defs") case final defs?
        when defs.childElements.isEmpty) {
      defs.remove();
    }
    await file.writeAsString(document.toString());
  }
}
