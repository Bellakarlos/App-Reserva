import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'dart:convert';
import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'gallery.dart';
import 'import.dart';
import 'puebloCerro.dart';
import 'Chacahua.dart';
import 'biologicalRes.dart';
import 'sensitiveWild.dart';
import 'OceanAndBea.dart';
import 'noSmoking.dart';
import 'EmergencyContact.dart';
import 'bathRooms.dart';
import 'beachThing.dart';
import 'trails.dart';
import 'hiking.dart';
import 'beach.dart';
import 'wildlifeView.dart';
import 'exploretown.dart';
import 'map.dart';
import 'Welcome.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: showHome ? const HomePage() : const MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final controller = PageController();
  bool isLastPage = false;
  late AnimationController _controller;
  late Animation<double> opacidad;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Widget buildPage({
    required Color colorF,
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0, // establecer el ancho máximo deseado
              height: 300.0, // establecer la altura máxima deseada
              child: Image.asset(
                urlImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 64),
            FittedBox(
              fit: BoxFit
                  .scaleDown, // Establece la escala del contenido para que quepa en el contenedor sin desbordarse
              child: AutoSizeText(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
                maxFontSize: 25, // Establece el tamaño máximo del texto
              ),
            ),
            const SizedBox(height: 17),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: FittedBox(
                  fit: BoxFit
                      .scaleDown, // Establece la escala del contenido para que quepa en el contenedor sin desbordarse
                  child: AutoSizeText(
                    subtitle,
                    style: TextStyle(
                      color: colorF,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    maxFontSize: 18, // Establece el tamaño máximo del texto
                  ),
                ))
          ],
        ),
      );

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    opacidad = Tween(begin: 0.0, end: 1.0).animate(_controller);
    // _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
    _controller.forward(from: 0.0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (i) {
              Future.delayed(const Duration(milliseconds: 80), () {
                setState(() => isLastPage = i == 3);
              });
            },
            children: [
              FadeTransition(
                opacity: opacidad,
                child: buildPage(
                    colorF: Colors.green,
                    color: const Color(0xFFEAFFED),
                    urlImage: 'images/Science.png',
                    title: "BIENVENIDO A",
                    subtitle: "Reserva Biologica Cerro Hermoso"),
              ),
              FadeTransition(
                opacity: opacidad,
                child: buildPage(
                    colorF: Colors.green,
                    color: const Color(0xFFEAFFED),
                    urlImage: 'images/tree.png',
                    title: "TITULO 2",
                    subtitle:
                        "texto/descripcion 2, aqui se puede introducir texto relevante a la reserva o alguna funcion"),
              ),
              FadeTransition(
                opacity: opacidad,
                child: buildPage(
                    colorF: Colors.green,
                    color: const Color(0xFFEAFFED),
                    urlImage: 'images/waterm.png',
                    title: "TITULO 3",
                    subtitle:
                        "texto/descripcion 3, aqui se puede introducir texto relevante a la reserva o alguna funcion"),
              ),
              FadeTransition(
                opacity: opacidad,
                child: buildPage(
                    colorF: Colors.green,
                    color: const Color(0xFFEAFFED),
                    urlImage: 'images/global.png',
                    title: "TITULO 4",
                    subtitle: "texto/descripcion 4, breve bienvenida"),
              )
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    primary: Colors.white,
                    backgroundColor: Colors.teal.shade700,
                    minimumSize: const Size.fromHeight(88)),
                child: const Text(
                  'Entendido',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => controller.animateToPage(3,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubicEmphasized),
                        child: const Text('skip')),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.black26,
                            activeDotColor: Colors.teal.shade700),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubicEmphasized),
                      ),
                    ),
                    TextButton(
                        onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubicEmphasized,
                            ),
                        child: const Text('Next'))
                  ],
                ),
              ),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Home(),
      );
    });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
  int _selectDrawerItem = 17;
  bool idioma = false;
  final Uri _url = Uri.parse('https://www.reservecerrohermoso.org');
  final Uri _urlDon = Uri.parse(
      'https://www.paypal.com/donate/?business=RYMNEEX638G8G&item_name=www.reservecerrohermoso.org&currency_code=USD');

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Import(idioma);
      case 1:
        return Gallery(idioma);
      case 2:
        return PuebloCerro(idioma);
      case 3:
        return Chacahua(idioma);
      case 4:
        return BiologicalRes(idioma);
      case 5:
        return SensitiveWild(idioma);
      case 6:
        return OceanAndBea(idioma);
      case 7:
        return NoSmoking(idioma);
      case 8:
        return EmergencyContact(idioma);
      case 9:
        return Bathrooms(idioma);
      case 10:
        return Beach(idioma);
      case 11:
        return Trails(idioma);
      case 12:
        return Hiking(idioma);
      case 13:
        return BeachThing(idioma);
      case 14:
        return WildlifeViewing(idioma);
      case 15:
        return ExploreTheTown(idioma);
      case 16:
        return Map(idioma);
      case 17:
        return const Welcome();
    }
  }

  _onselectItem(int i) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = i;
    });
  }

  void _showDialog(String message) {
    var json = jsonDecode(message);

    List<String> imagenes = [
      'images/dialogQR1.svg',
      'images/dialogQR2.svg',
      'images/dialogQR3.svg',
      'images/dialogQR4.svg',
      'images/dialogQR5.svg'
    ];
    Random random = new Random();
    String imagen = imagenes[random.nextInt(imagenes.length)];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      json['nombre'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1, // Altura de la línea
                    thickness: 1, // Grosor de la línea
                    color: Colors.grey, // Color de la línea
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Descripción:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          json['descripcion'],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Familia:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          json['familia'],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Ubicación:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          json['descripcion'],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Historia:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          json['historia'],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      imagen,
                      height: 120,
                      width: 120,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cerrar',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future _scanQR() async {
    String qrCodeResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancelar", false, ScanMode.QR);

    _showDialog(qrCodeResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Cerro Hermoso'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.greenAccent, Colors.green])),
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(50.0),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'images/logoreserva.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(1),
                    child: Text('Biological Reserve Cerro Hermoso'),
                  ),
                  GestureDetector(
                    child: const Text(
                      "www.reservecerrohermoso.org",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black45),
                    ),
                    onTap: () {
                      launchUrl(_url);
                    },
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Welcome'),
              leading: const Icon(Icons.home),
              selected: (17 == _selectDrawerItem),
              onTap: () {
                _onselectItem(17);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.nature_people),
              title: const Text('Who We Are'),
              children: <Widget>[
                ListTile(
                  title: const Text('mission statement'),
                  selected: (0 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(0);
                  },
                ),
                ListTile(
                  title: const Text('vision statement'),
                  selected: (1 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(1);
                  },
                ),
              ],
              initiallyExpanded:
                  (_selectDrawerItem < 2 && _selectDrawerItem > -1),
            ),
            ExpansionTile(
              leading: const Icon(Icons.groups),
              title: const Text('Community'),
              children: <Widget>[
                ListTile(
                  title: const Text('Pueblo Cerro Hermoso'),
                  selected: (2 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(2);
                  },
                ),
                ListTile(
                  title: const Text('Chacahua, National Park'),
                  selected: (3 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(3);
                  },
                ),
                ListTile(
                  title: const Text('Biological Reserve Cerro Hermoso'),
                  selected: (4 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(4);
                  },
                ),
              ],
              initiallyExpanded:
                  (_selectDrawerItem < 5 && _selectDrawerItem > 1),
            ),
            ExpansionTile(
              leading: const Icon(Icons.security),
              title: const Text('Safety'),
              children: <Widget>[
                ListTile(
                  title: const Text('Sensitive wildlife'),
                  selected: (5 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(5);
                  },
                ),
                ListTile(
                  title: const Text('Ocean, Beach and Exploring'),
                  selected: (6 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(6);
                  },
                ),
                ListTile(
                  title: const Text('No Smoking'),
                  selected: (7 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(7);
                  },
                ),
                ListTile(
                  title: const Text('Emergency contact'),
                  selected: (8 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(8);
                  },
                ),
              ],
              initiallyExpanded:
                  (_selectDrawerItem < 9 && _selectDrawerItem > 4),
            ),
            ExpansionTile(
              leading: const Icon(Icons.cabin),
              title: const Text('Amenities'),
              children: <Widget>[
                ListTile(
                  title: const Text('Bathrooms'),
                  selected: (9 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(9);
                  },
                ),
                ListTile(
                  title: const Text('Beach'),
                  selected: (10 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(10);
                  },
                ),
                ListTile(
                  title: const Text('Trails'),
                  selected: (11 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(11);
                  },
                ),
              ],
              initiallyExpanded:
                  (_selectDrawerItem < 12 && _selectDrawerItem > 8),
            ),
            ExpansionTile(
              leading: const Icon(Icons.emoji_people),
              title: const Text('Things To Do'),
              children: <Widget>[
                ListTile(
                  title: const Text('Hiking'),
                  selected: (12 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(12);
                  },
                ),
                ListTile(
                  title: const Text('Beach'),
                  selected: (13 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(13);
                  },
                ),
                ListTile(
                  title: const Text('Wildlife viewing'),
                  selected: (14 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(14);
                  },
                ),
                ListTile(
                  title: const Text('Explore the town'),
                  selected: (15 == _selectDrawerItem),
                  onTap: () {
                    _onselectItem(15);
                  },
                ),
              ],
              initiallyExpanded:
                  (_selectDrawerItem < 16 && _selectDrawerItem > 11),
            ),
            ListTile(
              title: const Text('Map'),
              leading: const Icon(Icons.map),
              selected: (16 == _selectDrawerItem),
              onTap: () {
                _onselectItem(16);
              },
            ),
            Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                      onPressed: () {
                        launchUrl(_urlDon);
                      },
                      child: const Text('Donate'),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFC2E3D8),
                          onPrimary: Colors.black))),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _scanQR,
          child: const Icon(Icons.qr_code_scanner),
          backgroundColor: Colors.green,
          tooltip: 'Escanear QR'),
      body: _getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
