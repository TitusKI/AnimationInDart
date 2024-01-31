import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/cat.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;
  @override
  void initState() {
    super.initState();

    boxController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
        CurvedAnimation(parent: boxController, curve: Curves.easeInOut));
    boxController.forward();
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    catController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    catAnimation = Tween(begin: -40.0, end: -170.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  tapping() {
    if (catAnimation.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catAnimation.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  build(context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(textAlign: TextAlign.center, "TAP THE BOX!!!",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,shadows: CupertinoContextMenu.kEndBoxShadow, fontSize: 30,textBaseline: TextBaseline.ideographic),
        selectionColor: Colors.white,
        ),
        backgroundColor: Colors.brown,
      ),
      body: GestureDetector(
        onTap: tapping,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
      ),
    );
  }

  buildCatAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (context, child) {
          return Positioned(
            right: 0.0,
            left: 0.0,
            top: catAnimation.value,
            child: const Cat(),
          );
        });
  }

  buildBox() {
    return Container(
      color: Colors.brown,
      width: 200.0,
      height: 220.0,
      margin: const EdgeInsets.only(bottom: 20.0),
    );
  }

  buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(width: 125, height: 10, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          );
        },
      ),
    );
  }

  buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(width: 125, height: 10, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            angle: -boxAnimation.value,
            alignment: Alignment.topRight,
            child: child,
          );
        },
      ),
    );
  }
}
