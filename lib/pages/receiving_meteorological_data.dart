import 'dart:io';
import 'package:flutter/material.dart';
import 'package:forecast/widgets/drawer.dart';
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';
import 'package:latlong2/latlong.dart';
import 'package:forecast/pages/enter_data_chemicals.dart';

class ReceivingMeteorologicalData extends StatelessWidget {
  static const String route = 'ReceivingMeteorologicalData';
  ReceivingMeteorologicalData({Key? key}) : super(key: key);

  final client = HttpClient();

  @override
  Widget build(BuildContext context) {
    double temperature = 0;
    double windspeed = 0;
    double winddirection = 0;
    int weathercode = 0;
    String verticalStability = '';
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    List<LatLng> tappedPoints = [
      (context.watch<GetTappedPoints>().getTappedPoints)
    ];

    var latitude = double.parse(tappedPoints.map((e) => e.latitude).join());
    var longitude = double.parse(tappedPoints.map((e) => e.longitude).join());

    Future<String> getWeather() async {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,soil_temperature_0cm&current_weather=true&windspeed_unit=ms&start_date=$formattedDate&end_date=$formattedDate');
      final request = await client.getUrl(url);
      final response = await request.close();
      final jsonStrings = await response.transform(utf8.decoder).toList();

      final jsonString = jsonStrings.join();
      final json = jsonDecode(jsonString);
      temperature = json["current_weather"]["temperature"];
      weathercode = json["current_weather"]["weathercode"];
      windspeed = json["current_weather"]["windspeed"];
      winddirection = json["current_weather"]["winddirection"].toDouble();

      String currentTime = json["current_weather"]["time"];
      String newTime = currentTime.replaceRange(
          currentTime.length - 2, currentTime.length, "00");
      var currentHourly = json["hourly"]["time"].indexOf(newTime);
      double currentSoilTemperature =
          json["hourly"]["soil_temperature_0cm"][currentHourly];
      double currentTemperature =
          json["hourly"]["temperature_2m"][currentHourly];

      double vertStability = (currentSoilTemperature - currentTemperature) /
          pow((windspeed + 0.0001), 2);

      if (vertStability >= 0.1) {
        verticalStability = 'Конвекція';
      } else if (vertStability <= -0.1) {
        verticalStability = 'Інверсія';
      } else {
        verticalStability = 'Ізотермія';
      }

      if (weathercode == 0) {
        return 'Чисте небо';
      } else if (weathercode == 1) {
        return 'Переважно ясно, мінлива хмарність';
      } else if (weathercode == 2) {
        return 'Переважно ясно, мінлива хмарність';
      } else if (weathercode == 3) {
        return 'Переважно ясно, мінлива хмарність';
      } else if (weathercode == 45) {
        return 'Туман';
      } else if (weathercode == 48) {
        return 'Паморозь';
      } else if (weathercode == 51) {
        return 'Мряка: легка інтенсивність';
      } else if (weathercode == 53) {
        return 'Мряка: помірна інтенсивність';
      } else if (weathercode == 55) {
        return 'Мряка: щільна інтенсивність';
      } else if (weathercode == 56) {
        return 'Крижана мряка: легка інтенсивність';
      } else if (weathercode == 57) {
        return 'Крижана мряка: щільна інтенсивність';
      } else if (weathercode == 61) {
        return 'Слабкий дощ';
      } else if (weathercode == 63) {
        return 'Помірний дощ';
      } else if (weathercode == 65) {
        return 'Сильний дощ';
      } else if (weathercode == 66) {
        return 'Крижаний дощ: легкий';
      } else if (weathercode == 67) {
        return 'Крижаний дощ: сильний';
      } else if (weathercode == 71) {
        return 'Снігопад: легкий';
      } else if (weathercode == 73) {
        return 'Снігопад: помірний';
      } else if (weathercode == 75) {
        return 'Снігопад: сильний';
      } else if (weathercode == 77) {
        return 'Снігові зерна';
      } else if (weathercode == 80) {
        return 'Зливи: слабкі';
      } else if (weathercode == 81) {
        return 'Зливи: помірні';
      } else if (weathercode == 82) {
        return 'Зливи: сильні';
      } else if (weathercode == 85) {
        return 'Слабкий сніг';
      } else if (weathercode == 86) {
        return 'Сильний сніг';
      } else if (weathercode == 95) {
        return 'Гроза: Слабка або помірна';
      } else if (weathercode == 96) {
        return 'Гроза зі слабким градомг';
      } else if (weathercode == 99) {
        return 'Гроза із сильним градом';
      } else {
        return '';
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Поточні метеодані')),
      drawer: buildDrawer(context, route),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              FutureBuilder<String>(
                future: getWeather(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                        child: Table(
                          columnWidths: const {1: FractionColumnWidth(.25)},
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 222, 224, 224),
                                ),
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: const Text(
                                          "Температура повітря (°C)",
                                          textScaleFactor: 0.95)),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: Text(temperature.toString(),
                                          textScaleFactor: 1)),
                                ]),
                            TableRow(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 236, 239, 240),
                                ),
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: const Text(
                                          "Швидкість вітру (м/сек)",
                                          textScaleFactor: 0.95)),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: Text(windspeed.toString(),
                                          textScaleFactor: 1)),
                                ]),
                            TableRow(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 222, 224, 224),
                                ),
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: const Text("Напрямок вітру (°)",
                                          textScaleFactor: 0.95)),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: Text(winddirection.toString(),
                                          textScaleFactor: 1)),
                                ]),
                            TableRow(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 236, 239, 240),
                                ),
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: const Text(
                                          "Вертикальна стійкість повітря",
                                          textScaleFactor: 0.95)),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: Text(
                                        verticalStability,
                                        textScaleFactor: 1,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      )),
                                ]),
                            TableRow(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 222, 224, 224),
                                ),
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 5.0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child: Text("${snapshot.data}",
                                          textScaleFactor: 0.95)),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          bottom: 10.0,
                                          top: 10.0,
                                          right: 10.0),
                                      child:
                                          const Text('', textScaleFactor: 1)),
                                ]),
                          ],
                        ),
                      ),
                    ];
                  } else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Помилка: ${snapshot.error}'),
                      ),
                    ];
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          'Трохи зачекайте...',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  context
                      .read<GetVerticalStability>()
                      .changeVerticalStability(verticalStability);

                  context.read<GetWindSpeed>().changeWindSpeed(windspeed);
                  context.read<GetTemperature>().changeTemperature(temperature);
                  context
                      .read<GetWindDirection>()
                      .changeWindDirection(winddirection);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const EnterDataChemicals();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.settings),
                label: const Text('Внести показники до вихідних даних'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
