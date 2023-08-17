import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:sizer/sizer.dart';

class Map extends StatefulWidget {
  bool idioma;
  Map(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MapState();
  }
}

class MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 50.0,
      minScale: 0.25,
      child: SvgPicture.asset(
        'images/Mapa.svg',
        width: 700.sp,
        height: 800.sp,
        // color: Colors.green,
        theme: const SvgTheme(
          currentColor: Colors.green,
        ),
      ),
    );
  }
}
