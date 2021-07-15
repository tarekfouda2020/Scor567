import 'package:flutter/material.dart';

class BallSpin extends StatefulWidget {
  @override
  BallSpinState createState() => BallSpinState();
}

class BallSpinState extends State<BallSpin>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: 0, end: 3 * 3.14).animate(controller);
    return Container(
      width: 50,
      height: 50,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value.toDouble(),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/vollyBall.png"))),
              ),
            );
          }),
    );
  }
}
