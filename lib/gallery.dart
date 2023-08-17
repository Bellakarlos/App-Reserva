import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  bool idioma;
  Gallery(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return GalleryState();
  }
}

class GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "VISION STATEMENT",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff417162)),
              ),
            ],
          ),
          color: const Color(0xFFC2E3D8),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 5),
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("images/imagenj.png")),
              const Padding(padding: EdgeInsets.only(top: 50)),
              Container(
                margin: const EdgeInsets.only(
                    left: 35, right: 35, top: 10, bottom: 10),
                child: const Text(
                  "Comunidades sostenibles que preservan los hábitats naturales y vida silvestre.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff417162),
                  ),
                ),
              ),
            ],
          ),
          color: const Color(0xFFC2E3D8),
        ),
      ],
    );
  }
}
