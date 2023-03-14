import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:forecast/widgets/drawer.dart';
import 'package:latlong2/latlong.dart';
// ignore: depend_on_referenced_packages
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  static const String route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LatLng> tappedPoints = [
      (context.watch<GetTappedPoints>().getTappedPoints)
    ];

    double newZoom = context.watch<GetZoom>().getZoom;
    double radAcid =
        context.watch<GetRadiusAccident>().getRadiusAccident * 1000;
    double globDepth = context.watch<GetGlobalDepth>().getGlobalDepth * 1000;
    double primaryDepth = context.watch<GetPrimaryDepth>().getPrimaryDepth;
    double secondDepth = context.watch<GetSecondaryDepth>().getSecondaryDepth;
    double areaZMHZ = 3.1415 * pow((globDepth / 1000), 2);
    double areaFirst = context.watch<GetAreaFirst>().getAreaFirst;
    double areaSecond = context.watch<GetAreaSecond>().getAreaSecond;
    double areaPZHZ = context.watch<GetAreaPZHZ>().getAreaPZHZ;
    String chemical = context.watch<GetNameChemical>().getName;
    double amount = context.watch<GetEmountNHR>().getEmountNHR / 1000;

    final markers = tappedPoints.map((latlng) {
      return Marker(
        width: 60,
        height: 40,
        point: latlng,
        builder: (ctx) => GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              duration: const Duration(seconds: 15),
              backgroundColor: Colors.blue,
              content: Text(
                "Хімічна речовина: $chemical, масса: ${amount.toStringAsFixed(3)} т\nГлибина ЗМХЗ: ${(globDepth / 1000).toStringAsFixed(3)} км, площа ЗМХЗ: ${areaZMHZ.toStringAsFixed(3)} кв.км \nПервинна хмара: глибина ${primaryDepth.toStringAsFixed(3)} км, площа ${areaFirst.toStringAsFixed(3)} кв.км\nВторинна хмара: глибина ${secondDepth.toStringAsFixed(3)} км, площа ${areaSecond.toStringAsFixed(3)} кв.км \nПлоща ПЗХЗ ${areaPZHZ.toStringAsFixed(3)} кв.км",
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 13,
                ),
              ),
            ));
          },
          child: const Icon(
            Icons.center_focus_weak,
            color: Colors.red,
            size: 40,
          ),
        ),
      );
    }).toList();

    var x = double.parse(tappedPoints.map((e) => e.latitude).join());
    var y = double.parse(tappedPoints.map((e) => e.longitude).join());

    List<LatLng> cloudeOne = [];

    cloudOne() {
      double lat = x;
      double lng = y;
      int anglF1 = context.watch<GetAnglF1>().getAnglF1;
      double radAsid = context.watch<GetRadiusAccident>().getRadiusAccident;
      double primDepth = context.watch<GetPrimaryDepth>().getPrimaryDepth;
      double directionWind = context.watch<GetWindDirection>().getWindDirection;

      double latOne = x;
      double lngOne = y;
      if (primDepth == 0) {
        latOne = lat;
        lngOne = lng;
        cloudeOne.add(LatLng(latOne, lngOne));
      } else {
        cloudeOne.add(LatLng(latOne, lngOne));
        for (var i = (0 - anglF1); i <= anglF1; i++) {
          latOne = lat +
              ((((primDepth + radAsid) * 1000) *
                      cos((i + directionWind) * 3.1415 / 180)) /
                  (6371000 * 3.1415 / 180));
          lngOne = lng +
              (primDepth + radAsid) *
                  1000 *
                  sin((i + directionWind) * 3.1415 / 180) /
                  cos(lat * 3.1415 / 180) /
                  (6371000 * 3.1415 / 180);
          cloudeOne.add(LatLng(latOne, lngOne));
        }
      }

      double anglF2 = context.watch<GetAnglF2>().getAnglF2;
      double secDepth = context.watch<GetSecondaryDepth>().getSecondaryDepth;

      double latTwo = x;
      double lngTwo = y;
      List<LatLng> result = [];

      if (secDepth == 0) {
        latTwo = lat;
        lngTwo = lng;
        result.add(LatLng(latTwo, lngTwo));
      } else {
        result.add(LatLng(latTwo, lngTwo));
        for (var i = (0 - anglF2); i <= anglF2; i++) {
          latTwo = lat +
              ((((secDepth + radAsid) * 1000) *
                      cos((i + directionWind) * 3.1415 / 180)) /
                  (6371000 * 3.1415 / 180));
          lngTwo = lng +
              (secDepth + radAsid) *
                  1000 *
                  sin((i + directionWind) * 3.1415 / 180) /
                  cos(lat * 3.1415 / 180) /
                  (6371000 * 3.1415 / 180);
          result.add(LatLng(latTwo, lngTwo));
        }
      }
      return result;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Прогноз наслідків аварій на ХНО'),
        titleTextStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: buildDrawer(context, route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              'Координати: ${x.toStringAsFixed(3)},  ${y.toStringAsFixed(3)}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    onPositionChanged: (position, hasGesture) {
                      final zoom = position.zoom as double;
                      context.read<GetZoom>().changeZoom(zoom);
                    },
                    interactiveFlags:
                        InteractiveFlag.all & ~InteractiveFlag.rotate,
                    center: LatLng(x, y),
                    zoom: newZoom,
                    rotation: 0,
                    onTap: (TapPosition tapPosition, LatLng latlng) {
                      context
                          .read<GetTappedPoints>()
                          .changeTappedPoints(latlng);
                    }),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  CircleLayer(circles: [
                    CircleMarker(
                      point: LatLng(x, y),
                      color: Colors.red.withOpacity(0.3),
                      borderStrokeWidth: 3,
                      useRadiusInMeter: true,
                      radius: radAcid,
                    ),
                    CircleMarker(
                      point: LatLng(x, y),
                      color: const Color.fromARGB(255, 210, 247, 5)
                          .withOpacity(0.2),
                      borderStrokeWidth: 1,
                      useRadiusInMeter: true,
                      radius: globDepth,
                    ),
                  ]),
                  PolygonLayer(polygons: [
                    Polygon(
                      points: cloudeOne,
                      label: 'Первинна хмара',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 1, 117, 7),
                        fontSize: 12,
                      ),
                      labelPlacement: PolygonLabelPlacement.polylabel,
                      isFilled: false,
                      borderColor: Colors.green,
                      borderStrokeWidth: 3,
                    ),
                    Polygon(
                      points: cloudOne(),
                      label: 'Вторинна хмара',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 54, 0, 179),
                        fontSize: 12,
                      ),
                      labelPlacement: PolygonLabelPlacement.polylabel,
                      isFilled: false, // By default it's false
                      borderColor: Colors.blue,
                      borderStrokeWidth: 3,
                    ),
                  ]),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
