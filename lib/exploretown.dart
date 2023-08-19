import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

import 'package:geolocator/geolocator.dart';

class ExploreTheTown extends StatefulWidget {
  bool idioma;
  ExploreTheTown(this.idioma, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ExploreTheTownState();
  }
}

class ExploreTheTownState extends State<ExploreTheTown> {
  List<Map<String, double>> locationList = [];
  bool isRecording = false;
  String distancia = 'distancia desconocida';

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // Radio de la Tierra en kilómetros

    double dLat = pi / 180 * (lat2 - lat1);
    double dLon = pi / 180 * (lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(pi / 180 * (lat1)) * cos(pi / 180 * (lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c; // Distancia en kilómetros
    return distance;
  }

  void getLocationList() async {
    if (isRecording) {
      setState(() {
        isRecording = false;
      });
    } else {
      setState(() {
        isRecording = true;
      });

      while (isRecording) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        Map<String, double> location = {
          'lt': position.latitude,
          'lg': position.longitude,
        };
        setState(() {
          if (locationList.isNotEmpty) {
            Map<String, double> lastLocation = locationList.last;
            double? lat1 = lastLocation['lt'];
            double? lon1 = lastLocation['lg'];

            double distance = calculateDistance(
                    lat1!, lon1!, position.latitude, position.longitude) *
                1000;
            distancia = distance.toStringAsFixed(2);
            locationList.add(location);
          } else {
            locationList.add(location);
          }
        });
        await Future.delayed(
            Duration(milliseconds: 2000)); // Grabar cada 5 segundos
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              LocationPermission permission =
                  await Geolocator.checkPermission();
              if (permission == LocationPermission.deniedForever) {
                // Permiso denegado para siempre, mostrar un mensaje de error o abrir configuraciones de la aplicación
                return;
              }

              if (permission == LocationPermission.denied) {
                // Permiso denegado, solicitar permisos
                permission = await Geolocator.requestPermission();
                if (permission != LocationPermission.whileInUse &&
                    permission != LocationPermission.always) {
                  // Permiso denegado nuevamente, mostrar un mensaje de error o abrir configuraciones de la aplicación
                  return;
                }
              }

              // Permiso otorgado, obtener la ubicación
              getLocationList();
            },
            child:
                Text(isRecording ? 'Detener Grabación' : 'Comenzar Grabación'),
          ),
          const SizedBox(height: 20),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Latitud: $distancia',
                  style: TextStyle(fontSize: 14.sp),
                )
              ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: locationList.map((location) {
              return Text(
                'Latitud: ${location['lt']}, Longitud: ${location['lg']}',
                style: TextStyle(fontSize: 14.sp),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
