import 'package:flutter/material.dart';

class BeachThing extends StatefulWidget {
  bool idioma;
  BeachThing(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BeachThingState();
  }
}

class BeachThingState extends State<BeachThing> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
