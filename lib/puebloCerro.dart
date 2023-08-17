import 'package:flutter/material.dart';

class PuebloCerro extends StatefulWidget {
  bool idioma;
  PuebloCerro(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PuebloCerroState();
  }
}

class PuebloCerroState extends State<PuebloCerro> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
