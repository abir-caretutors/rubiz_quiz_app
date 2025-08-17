import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class LatexRichTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double mathFontSize;

  const LatexRichTextWidget({
    super.key,
    required this.text,
    this.style,
    this.mathFontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'(\$\$.*?\$\$)');
    final parts = <String>[];

    int lastIndex = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        parts.add(text.substring(lastIndex, match.start));
      }
      parts.add(match.group(0)!);
      lastIndex = match.end;
    }
    if (lastIndex < text.length) {
      parts.add(text.substring(lastIndex));
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: parts.where((part) => part.isNotEmpty).map((part) {
        if (part.startsWith(r'$$') && part.endsWith(r'$$')) {
          final latex = part.substring(2, part.length - 2).trim();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Math.tex(
              latex,
              textStyle: TextStyle(fontSize: mathFontSize),
              mathStyle: MathStyle.text,
            ),
          );
        } else {
          return Text(
            part,
            style: style ?? const TextStyle(fontSize: 18),
          );
        }
      }).toList(),
    );
  }
}
