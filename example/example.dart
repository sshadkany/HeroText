import 'package:flutter/material.dart' hide Hero;
import 'package:hero_text/hero_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hero Text demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Center(
        child: PageA(),
      ),
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.yellow,
      child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const PageB(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 3000),
                  reverseTransitionDuration:
                      const Duration(milliseconds: 1000)),
            );
          },
          child: HeroText(
            tag: 'tag',
            child: Text(
              'Any fortunes you wish for yourself,',
              style: Theme.of(context).textTheme.headline5,
            ),
          )),
    ));
  }
}

class PageB extends StatelessWidget {
  const PageB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 100),
            color: Colors.blue,
            child: Center(
                child: HeroText(
                    tag: 'tag',
                    child: Text(
                      'wish it for others too',
                      style: Theme.of(context).textTheme.headline1,
                    )))));
  }
}
