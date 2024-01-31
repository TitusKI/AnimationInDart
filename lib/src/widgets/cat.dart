import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

class Cat extends StatelessWidget {


  const Cat({super.key});
  @override
  build(context) {
    return Image.asset("assets/Images.png");
    //   Container(
    //   color: Colors.lightBlueAccent,
    //   width: 300.0,
    //   height: 100.0,
    // );

    // return Image.network('https://i.imgur.com/QwhZRyL.png');
  }
}
