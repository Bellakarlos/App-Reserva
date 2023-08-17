import 'package:flutter/material.dart';

class EmergencyContact extends StatefulWidget {
  bool idioma;
  EmergencyContact(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EmergencyContactState();
  }
}

class EmergencyContactState extends State<EmergencyContact> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
