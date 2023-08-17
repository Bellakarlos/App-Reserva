import 'package:flutter/material.dart';

class Bathrooms extends StatefulWidget {
  bool idioma;
  Bathrooms(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return BathroomsState();
  }
}

class BathroomsState extends State<Bathrooms> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
