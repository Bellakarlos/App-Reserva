import 'package:flutter/material.dart';

class Chacahua extends StatefulWidget {
  bool idioma;
  Chacahua(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChacahuaState();
  }
}

class ChacahuaState extends State<Chacahua> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
