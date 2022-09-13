/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * originally was created by Razeware
 * was modified by Sajjad
 */
// ignore_for_file: omit_local_variable_types
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';

class CalculateParagraph {
  CalculateParagraph(
      {required this.paragraphStyle,
      required this.textStyle,
      required this.text,
      required this.splitChar,
      required this.maxWidth});

  ui.ParagraphStyle? paragraphStyle;
  ui.TextStyle? textStyle;
  String text;
  double maxWidth;
  String splitChar;

  void layout() => _layout();

  void _layout() {
    _calculateRuns();
    _calculateBoundForTexts();
  }

  void _calculateBoundForTexts() {
    double sum = 0;
    double left = 0;
    double top = 0;
    for (var r in _runs) {
      sum += r.paragraph.maxIntrinsicWidth;
      if (sum > maxWidth) {
        left = 0;
        sum = r.paragraph.maxIntrinsicWidth;
        top = top + r.paragraph.height;
      }
      positions.add(Rect.fromLTRB(left, top, sum, top + r.paragraph.height));
      left = sum;
    }
  }

  final List<TextRun> _runs = [];
  List<Rect> positions = [];

  void _calculateRuns() {
    if (_runs.isNotEmpty) {
      return;
    }

    final breaker = LineBreaker(text, splitChar);
    final breakCount = breaker.computeBreaks();
    final breaks = breaker.breaks;

    var start = 0;
    int end;
    for (var i = 0; i < breakCount; i++) {
      end = breaks[i];
      _addRun(start, end);
      start = end;
    }
    end = text.length;
    if (start < end) {
      _addRun(start, end);
    }
  }

  void _addRun(int start, int end) {
    if (paragraphStyle == null) {
      return;
    }
    if (textStyle == null) {
      return;
    }
    final builder = ui.ParagraphBuilder(paragraphStyle!)
      ..pushStyle(textStyle!)
      ..addText(text.substring(start, end));
    final paragraph = builder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: double.infinity));
    final run = TextRun(start, end, paragraph);
    _runs.add(run);
  }
}

class LineBreaker {
  LineBreaker(this.text, this.splitChar);

  String text;
  List<int> _breaks = [];
  String splitChar;

  int computeBreaks() {
    if (_breaks.isNotEmpty) {
      return _breaks.length;
    }
    _breaks = [];

    for (var i = 1; i < text.length; i++) {
      if (isBreakChar(text[i - 1]) && !isBreakChar(text[i])) {
        _breaks.add(i);
      }
    }

    return _breaks.length;
  }

  List<int> get breaks => _breaks;

  bool isBreakChar(String codeUnit) {
    return codeUnit == splitChar;
  }
}

class TextRun {
  TextRun(this.start, this.end, this.paragraph);

  int start;
  int end;
  ui.Paragraph paragraph;
}
