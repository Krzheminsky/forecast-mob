// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:forecast/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';
import 'package:forecast/pages/data.dart' as data;

class ResultPossibleLosses extends StatelessWidget {
  static const String route = 'ResultPossibleLosses';
  const ResultPossibleLosses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double populationPZHZ = 0;
    double numberAffected = 0;
    double transferSpeed = 0;
    double duration = 0;
    double approachTime = 0;
    String dissemination = '';
    losses() {
      double globalDepth = context.watch<GetGlobalDepth>().getGlobalDepth;
      double areaAffected = context.watch<GetAffectedArea>().getAffectedArea;
      double populationDensity =
          context.watch<GetPopulationDensity>().getPopulationDensity;
      double distanceSource =
          context.watch<GetDistanceToTheObject>().getDistanceToTheObject;
      double coefficientProtection =
          context.watch<GetProtectionFactor>().getProtectionFactor;
      String vertical =
          context.watch<GetVerticalStability>().getVerticalStability;
      Map<String, dynamic> vertStab = data.verticalStability[vertical];
      double vert = vertStab["param"];
      double windSpeed = context.watch<GetWindSpeed>().getWindSpeed;
      double evaporationTime =
          context.watch<GetEvaporationTime>().getEvaporationTime;
      double timeMoment =
          context.watch<GetTimeSinceAccident>().getTimeSinceAccident;
      if (distanceSource > globalDepth) {
        populationPZHZ = 0;
      } else {
        populationPZHZ = (populationDensity * areaAffected / 1000);
      }

      numberAffected = populationPZHZ * (1 - coefficientProtection);

      duration = evaporationTime * 60;

      if (vert == 0.15) {
        transferSpeed = windSpeed * 5.24;
      } else if (vert == 0) {
        transferSpeed = windSpeed * 5.8;
      } else {
        transferSpeed = windSpeed * 7;
      }
      approachTime = ((distanceSource / transferSpeed) * 60);

      if ((timeMoment / 60 * transferSpeed) < globalDepth) {
        dissemination = (timeMoment / 60 * transferSpeed).toStringAsFixed(3);
      } else {
        dissemination = "досягла максимуму";
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Можливі втрати населення')),
      drawer: buildDrawer(context, route),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                child: Table(
                  columnWidths: const {1: FractionColumnWidth(.2)},
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 236, 239, 240),
                        ),
                        children: [
                          Container(
                              child: const Text(
                            "Результати розрахунків",
                            textScaleFactor: 0.1,
                            style: TextStyle(
                              color: Color.fromARGB(255, 236, 239, 240),
                            ),
                          )),
                          Container(
                              child: Text(
                            losses().toString(),
                            textScaleFactor: 0.1,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 236, 239, 240),
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
                              child: const Text(
                                  "Кількість населення в ПЗХЗ (тис.чол)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(populationPZHZ.toStringAsFixed(3),
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
                                  "Прогнозована кількість уражених (тис.чол.)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(numberAffected.toStringAsFixed(3),
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
                              child: const Text(
                                  "Тривалість хімічного забруднення (хв.)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(duration.toStringAsFixed(3),
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
                                  "Швидкість перенесення фронту хмари (км/год)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(transferSpeed.toStringAsFixed(3),
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
                              child: const Text("Час підходу хмари (хв.)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(approachTime.toStringAsFixed(1),
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
                                  "Глибина розповсюдження хмари з моменту аварії (км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(dissemination, textScaleFactor: 0.9)),
                        ]),
                  ],
                ),
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
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(Icons.settings),
                label: const Text('Клацніть, щоб перейти до мапи'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
