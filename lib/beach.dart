import 'package:flutter/material.dart';

class Beach extends StatefulWidget {
  bool idioma;
  Beach(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BeachState();
  }
}

class BeachState extends State<Beach> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
