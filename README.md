<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

[Hero](https://api.flutter.dev/flutter/widgets/Hero-class.html) Effect for common words of text widget (something like magic move in keynote)

## Features

![HeroText](https://github.com/sshadkany/HeroText/blob/master/example/img/BrowserPreview.gif?raw=true)

## Usage
 Usage is easily and likes `Hero`,but obviously the child should be `Text`.
 don't forget to increase `transitionDuration` (look at example for more).
```dart
HeroText(
   tag: 'tag',
   child: Text(
       'To be, or not to be, that is the question',
       style: Theme.of(context).textTheme.headline5,
   ),
)
```
