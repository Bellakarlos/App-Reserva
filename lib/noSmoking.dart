import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:sizer/sizer.dart';

class NoSmoking extends StatefulWidget {
  bool idioma;
  NoSmoking(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NoSmokingState();
  }
}

class NoSmokingState extends State<NoSmoking> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 20.0,
      minScale: 0.25,
      child: SvgPicture.asset(
        'images/dialogQR1.svg',
        width: 500.sp,
        height: 500.sp,
      ),
    );
  }
}
