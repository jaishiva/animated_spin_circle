import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: SpinCircle(
        buttons: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class SpinCircle extends StatefulWidget {
  final List<Widget> buttons;
  const SpinCircle({Key key, @required this.buttons}) : super(key: key);

  @override
  _SpinCircleState createState() => _SpinCircleState();
}

class _SpinCircleState extends State<SpinCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double circleRadius = 120;

  @override
  void initState() {
    if (widget.buttons.length != 3) {
      throw Exception('The number of buttons must be 3');
    }
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleRadius,
      height: circleRadius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRect(
            clipper: Clipr(),
            child: Stack(children: [
              Transform.rotate(
                angle: pi * _animationController.value,
                child: Transform.rotate(
                  angle: pi + pi / 4,
                  child: ClipRect(
                    clipper: Clipr(),
                    child: Container(
                      width: circleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red[900],
                      ),
                      child: null,
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi * _animationController.value,
                child: Transform.rotate(
                  angle: pi + pi / 8,
                  child: ClipRect(
                    clipper: Clipr(),
                    child: Container(
                      width: circleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900],
                      ),
                      child: null,
                    ),
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi * _animationController.value,
                child: Transform.rotate(
                  angle: pi,
                  child: ClipRect(
                    clipper: Clipr(),
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: circleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange[900],
                      ),
                      child: Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(0, -5),
                            child: widget.buttons[1],
                          ),
                          Transform.translate(
                              offset: Offset(-35, 15),
                              child: widget.buttons[0]),
                          Transform.translate(
                            offset: Offset(35, 15),
                            child: widget.buttons[2],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue[900]),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                if (_animationController.status == AnimationStatus.completed) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Clipr extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
