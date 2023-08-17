import 'package:flutter/material.dart';

class SensitiveWild extends StatefulWidget {
  bool idioma;
  SensitiveWild(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SensitiveWildState();
  }
}

class SensitiveWildState extends State<SensitiveWild> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
