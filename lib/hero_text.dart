library hero_text;

import 'package:flutter/material.dart';
import 'package:hero_text/dartui/calculate_paragraph.dart';

class HeroText extends StatefulWidget {
  const HeroText({required this.tag, required this.child, Key? key})
      : super(key: key);
  final String tag;
  final Text child;

  @override
  State<HeroText> createState() => _HeroTextState();
}

class _HeroTextState extends State<HeroText> {
  String fromString = '';
  final List<String> wordTagList = [];
  final List<String> splitCharWordList = [];
  final splitChar = ' ';

  @override
  void initState() {
    super.initState();
    fromString = "${widget.child.data ?? ""} ";
    wordTagList.addAll(_createTagList(fromString));
  }

  List<String> _createTagList(String input) {
    final wordList = input.split(splitChar);

    final resultList = List<String>.filled(wordList.length, '');
    final countMap = <String, int>{};
    for (var i = 0; i < wordList.length; i++) {
      if (countMap.containsKey(wordList[i])) {
        countMap.update(wordList[i], (value) => 1 + value);
      } else {
        countMap.putIfAbsent(wordList[i], () => 0);
      }
    }
    var countMapCopy = {}..addAll(countMap);

    for (var i = 0; i < wordList.length; i++) {
      var s = wordList[i];
      var current = countMap[s] ?? 0;
      var total = countMapCopy[s] ?? 0;

      resultList[i] = '$s${total - (current - 1)}';
      countMap[s] = current - 1;
    }
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    var calculateParagraph = CalculateParagraph(
      splitChar: splitChar,
      maxWidth: MediaQuery.of(context).size.width,
      paragraphStyle: widget.child.style?.getParagraphStyle(),
      text: fromString,
      textStyle: widget.child.style?.getTextStyle(),
    )..layout();
    var positions = calculateParagraph.positions;
    var split = fromString.split(splitChar);
    return Stack(
      children: List.generate(positions.length, (index) {
        return Positioned.fromRect(
          rect: positions[index],
          child: Hero(
            createRectTween: (begin, end) {
              return RectTween(begin: begin, end: end);
            },
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              var fromHero = fromHeroContext.widget as Hero;
              var fromText = fromHero.child as Text;

              var toHero = toHeroContext.widget as Hero;
              var toText = toHero.child as Text;
              return AnimatedBuilder(
                  animation: animation,
                  builder: (context, __) {
                    if (flightDirection == HeroFlightDirection.push) {
                      return Text(
                        split[index],
                        style: TextStyle.lerp(
                            fromText.style, toText.style, animation.value),
                      );
                    } else {
                      return Text(
                        split[index],
                        style: TextStyle.lerp(
                            toText.style, fromText.style, animation.value),
                      );
                    }
                  });
            },
            tag: '${widget.tag}${wordTagList[index]}',
            child: Text(
              split[index],
              style: widget.child.style,
            ),
          ),
        );
      }),
    );
  }
}
