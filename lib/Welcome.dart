import 'package:flutter/material.dart';

import 'widgets/post.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import 'dart:async';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  // bool idioma;
  // Welcome(this.idioma, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  Future<dynamic>? _websiteData;

  List<Article> imgs = [];
  String urluno = "ENTR", h1 = "ENTR", titulo1 = "ENTR", des1 = "ENTR";
  String h2 = "ENTR", urldos = "ENTR", titulo2 = "ENTR", des2 = "ENTR";
  String urltres = "ENTR", h3 = "ENTR", titulo3 = "ENTR", des3 = "ENTR";

  int currentPos = 0;
  final Uri _url = Uri.parse('https://www.reservecerrohermoso.org/california');
  final Uri _urld =
      Uri.parse('https://www.reservecerrohermoso.org/habitats-clean-up');
  final Uri _urlt =
      Uri.parse('https://www.reservecerrohermoso.org/workshops-and-education');
  final Uri _urlc =
      Uri.parse('https://www.reservecerrohermoso.org/flora-fauna');

  Future<dynamic> getWebsiteData() async {
    final response =
        await http.get(Uri.parse('https://www.reservecerrohermoso.org/blog'));
    if (response.statusCode == 200) {
      final documento = parser.parse(response.body);
      // estos son los grupos de datos que extraemos
      final imagenes = documento.getElementsByClassName('hZSyIr');
      final srcList =
          imagenes.map((element) => element.attributes['src']).toList();
      final fechas = documento.getElementsByClassName('xUuoH9');
      final titulos = documento.getElementsByClassName('post-title__text');
      final descripciones = documento.getElementsByClassName('pAfFB0');
      final textList = descripciones.map((element) => element.text).toList();
      setState(() {
        urluno = srcList[0] ?? 'valor por defecto xd';
        urldos = srcList[1] ?? 'valor por defecto xd';
        urltres = srcList[2] ?? 'valor por defecto xd';

        titulo1 = titulos[0].text;
        titulo2 = titulos[1].text;
        titulo3 = titulos[2].text;

        h1 = fechas[0].children[0].text + " · " + fechas[0].children[2].text;
        h2 = fechas[1].children[0].text + " · " + fechas[1].children[2].text;
        h3 = fechas[2].children[0].text + " · " + fechas[2].children[2].text;

        des1 = textList[0];
        des2 = textList[1];
        des3 = textList[2];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _websiteData = getWebsiteData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _websiteData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Aquí creamos los widgets
          return ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        viewportFraction: 1.2,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayInterval: const Duration(milliseconds: 4500),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                      ),
                      items: [
                        Container(
                          // margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/imagen5.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/imagen1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/imagen2.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/imagen3.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // margin: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/imagen4.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                color: const Color(0xFFC2E3D8),
                padding: const EdgeInsets.only(bottom: 20),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40.sp, top: 40.sp),
                child: const Image(image: AssetImage('images/ciclo.png')),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10.sp),
                  child: Column(
                    children: [
                      Text(
                        'Presione sobre las etiquetas para conocer mas:',
                        style: TextStyle(fontSize: 8.sp),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            // color: Colors.amber,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTapUp: (details) => {launchUrl(_url)},
                                  child: Container(
                                    height: 90.sp,
                                    width: 24.6.w,
                                    color: Colors.black,
                                    padding: EdgeInsets.all(4.sp),
                                    // margin: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 9.sp),
                                          child: SvgPicture.asset(
                                            'images/Pino.svg',
                                            semanticsLabel: 'Acme Logo',
                                            color: const Color(0xFFC2E3D8),
                                            width: 7.2.sp,
                                          ),
                                        ),
                                        Text("REFORESTATION",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: const Color(0xFFC2E3D8),
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {launchUrl(_urld)},
                                  child: Container(
                                    height: 90.sp,
                                    width: 24.6.w,
                                    color: const Color(0xFF515E65),
                                    padding: EdgeInsets.all(4.sp),
                                    margin: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 11.sp),
                                          child: SvgPicture.asset(
                                            'images/arboles.svg',
                                            semanticsLabel: 'Acme Logo',
                                            color: const Color(0xFFC2E3D8),
                                            width: 18.sp,
                                          ),
                                        ),
                                        Text("HABITATS RESTORATION",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: const Color(0xFFC2E3D8),
                                                fontSize: 7.sp,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {launchUrl(_urlt)},
                                  child: Container(
                                    height: 90.sp,
                                    width: 24.6.w,
                                    color: const Color(0xFFEDEDED),
                                    padding: EdgeInsets.all(4.sp),
                                    margin: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 12.sp),
                                          child: SvgPicture.asset(
                                            'images/lapiz.svg',
                                            semanticsLabel: 'Acme Logo',
                                            color: Colors.black,
                                            width: 20.sp,
                                          ),
                                        ),
                                        Text("EDUCATION",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 7.5.sp)),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {launchUrl(_urlc)},
                                  child: Container(
                                    height: 90.sp,
                                    width: 24.6.w,
                                    color: const Color(0xFF9CC6B9),
                                    padding: EdgeInsets.all(4.sp),
                                    margin: const EdgeInsets.all(0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: 21.sp),
                                          child: SvgPicture.asset(
                                            'images/ave.svg',
                                            semanticsLabel: 'Acme Logo',
                                            color: const Color(0XFFF0FAFF),
                                            width: 21.sp,
                                          ),
                                        ),
                                        Text("PROTECTING \nWILDLIFE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: const Color(0xFFF0FAFF),
                                                fontSize: 7.2.sp,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PostWidget(
                    imageUrl: urluno,
                    title: titulo1,
                    time: h1,
                    description: des1),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PostWidget(
                    imageUrl: urldos,
                    time: titulo2,
                    title: h2,
                    description: des2),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: PostWidget(
                    time: des3,
                    imageUrl: urltres,
                    title: titulo3,
                    description: h3),
              ),
            ],
          );
        } else {
          // Todavía estamos cargando los datos
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Article {
  final String urlImages;

  const Article({required this.urlImages});
}

class ClientWithUserAgent extends http.BaseClient {
  final http.Client _client;

  ClientWithUserAgent(this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['User-Agent'] = 'user agent value';
    return _client.send(request);
  }
}


//tengo un problema, mi aplicacion hace una peticion http con la funcion getWebsiteData y espera a que