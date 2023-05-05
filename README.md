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

Using it is straightforward and similar to Flutter's `Hero`, but it is important to make sure that the child element is `Text Widget`, not anything else. It is also essential to adjust the `transitionDuration` parameter appropriately to achieve the desired effect. The provided example can offer further guidance on this matter.
```dart
HeroText(
   tag: 'tag',
   child: Text(
       'Any fortunes you wish for yourself,',
       style: Theme.of(context).textTheme.headline5,
   ),
)
```
