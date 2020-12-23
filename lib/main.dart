import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  List<Animation> curves;
  List<Animation<double>> animationSizes;
  Animatable<Color> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    curves = [
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
      CurvedAnimation(parent: controller, curve: Curves.easeInToLinear),
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
      CurvedAnimation(parent: controller, curve: Curves.bounceIn),
      CurvedAnimation(parent: controller, curve: Curves.easeInOutCirc),
      CurvedAnimation(parent: controller, curve: Curves.elasticOut)
    ];
    animationSizes = List.generate(curves.length, (index) {
      var tempTween =
          Tween<double>(begin: 0, end: Random().nextInt(300).toDouble())
              .animate(curves[index])
                ..addListener(() {
                  setState(() {});
                });
      return tempTween;
    });

    colorAnimation = TweenSequence<Color>(
      [
        TweenSequenceItem(
          weight: 4.0,
          tween: ColorTween(
            begin: Colors.black,
            end: Colors.yellow,
          ),
        ),
        TweenSequenceItem(
          weight: 10.0,
          tween: ColorTween(
            begin: Colors.amber,
            end: Colors.pink,
          ),
        ),
        TweenSequenceItem(
          weight: 5.0,
          tween: ColorTween(
            begin: Colors.teal,
            end: Colors.brown,
          ),
        ),
      ],
    );

    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Custom Animation',
        home: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              animationSizes.length,
              (index) {
                return Container(
                  height: 30,
                  margin: EdgeInsets.only(top: 20),
                  width: animationSizes[index].value,
                  color: colorAnimation
                      .evaluate(AlwaysStoppedAnimation(controller.value)),
                );
              },
            )
          ],
        ));
  }
}
