import 'package:flutter/material.dart';

class Hiking extends StatefulWidget {
  bool idioma;
  Hiking(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HikingState();
  }
}

class HikingState extends State<Hiking> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
