import 'package:flutter/material.dart';

class Trails extends StatefulWidget {
  bool idioma;
  Trails(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TrailsState();
  }
}

class TrailsState extends State<Trails> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
