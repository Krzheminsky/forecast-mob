// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:forecast/widgets/drawer.dart';
import 'package:forecast/pages/data.dart' as data;
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';

class ResultsChemicalHazard extends StatefulWidget {
  static const String route = 'ResultsChemicalHazard';
  const ResultsChemicalHazard({Key? key}) : super(key: key);

  @override
  State<ResultsChemicalHazard> createState() => _ResultsChemicalHazardState();
}

class _ResultsChemicalHazardState extends State<ResultsChemicalHazard> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mapChemical = {};
    // ignore: unused_local_variable
    double? calcData;
    double coeficientA = 0;
    double coeficientB1 = 0;
    double coeficientB2 = 0;
    int angleF1 = 0;
    double radiusAccident = 0;
    num primaryCloud = 0;
    double secondaryCloud = 0;
    double diameterArea = 0;
    num evaporationRate = 0;
    double evaporationTime = 0;
    num primaCloud = 0;
    num secCloud = 0;
    double angleF2 = 0;
    double areaAccident = 0;
    double primaryDepth = 0;
    double secondaryDepth = 0;
    double globalDepth = 0;
    double areaZMHZ = 0;
    double areaFirst = 0;
    double areaSecond = 0;
    double areaPZHZ = 0;

    listChemicel() {
      String nameChimical = context.watch<GetNameChemical>().getName;
      Map<String, dynamic> chemicall = data.chemical[nameChimical];
      mapChemical.addAll(chemicall);
      double windSpeed = context.watch<GetWindSpeed>().getWindSpeed;
      double boilingPoint = chemicall["boilingPoint"];
      double calData = windSpeed * boilingPoint;
      calcData = calData;
      String vertical =
          context.watch<GetVerticalStability>().getVerticalStability;
      Map<String, dynamic> vertStab = data.verticalStability[vertical];
      double vert = vertStab["param"];
      double coefA = (0.57 * exp(0.86 * vert));
      coeficientA = coefA;
      double coefB1 = (15.4 * exp(6.96 * vert));
      coeficientB1 = coefB1;
      double coefB2 = (16.84 * exp(6.87 * vert));
      coeficientB2 = coefB2;

      String probab = context.watch<GetProbability>().getProbability;
      Map<String, dynamic> probability = data.probability[probab];
      double prob = probability["param"];
      if (vert == -0.15 && prob == 0.5) {
        angleF1 = 15;
      } else if (vert == -0.15 && prob == 0.75) {
        angleF1 = 25;
      } else if (vert == -0.15 && prob == 0.9) {
        angleF1 = 30;
      } else if (vert == 0 && prob == 0.5) {
        angleF1 = 12;
      } else if (vert == 0 && prob == 0.75) {
        angleF1 = 20;
      } else if (vert == 0 && prob == 0.9) {
        angleF1 = 25;
      } else if (vert == 0.15 && prob == 0.5) {
        angleF1 = 9;
      } else if (vert == 0.15 && prob == 0.75) {
        angleF1 = 15;
      } else {
        angleF1 = 20;
      }

      double amountNHR = context.watch<GetEmountNHR>().getEmountNHR;
      if (boilingPoint < 20 && amountNHR < 100000) {
        radiusAccident = 0.5;
      } else if (boilingPoint < 20 && amountNHR >= 100000) {
        radiusAccident = 1;
      } else if (boilingPoint >= 20 && amountNHR >= 100000) {
        radiusAccident = 0.5;
      } else {
        radiusAccident = 0.3;
      }

      String phisState = context.watch<GetPhisicalStat>().getPhisicalStat;
      Map<String, dynamic> phisDtat = data.phisical[phisState];
      int phis = phisDtat["param"];
      double coecificHeat = mapChemical["coecificHeat"];
      double airTemperature = context.watch<GetTemperature>().getTemperature;
      double vaporisation = mapChemical["vaporisation"];
      if (phis == 1 &&
          (amountNHR *
                  coecificHeat *
                  (airTemperature - boilingPoint) /
                  vaporisation >
              0)) {
        primaryCloud = amountNHR *
            coecificHeat *
            (airTemperature - boilingPoint) /
            vaporisation;
      } else if (phis == 0 &&
          (amountNHR *
                  coecificHeat *
                  (airTemperature - boilingPoint) /
                  vaporisation >
              0)) {
        primaryCloud = amountNHR;
      } else {
        primaryCloud = 0.0;
      }
      secondaryCloud = amountNHR - primaryCloud;

      double palletHeight = context.watch<GetPalletHeight>().getPalletHeight;
      double density = mapChemical["density"];
      if (palletHeight == 0) {
        diameterArea = 5.04 * (sqrt((amountNHR - primaryCloud) / density));
      } else if (palletHeight > 0 && amountNHR < 200000) {
        diameterArea = 1.22 * (sqrt((amountNHR - primaryCloud) / density));
      } else {
        diameterArea = 1.22 /
            sqrt(palletHeight) *
            (sqrt((amountNHR - primaryCloud) / density));
      }

      double surfaceArea = 3.1415 * diameterArea * diameterArea / 4;

      double molWeight = mapChemical["molWeight"];
      if (phis == 0) {
        evaporationRate = 0;
      } else {
        evaporationRate = (0.041 *
            ((windSpeed * molWeight) / (pow(diameterArea, 0.14) * 273)) *
            exp((vaporisation * molWeight / 8.31) *
                ((1 / (boilingPoint + 273)) - (1 / 273))));
      }

      if (phis == 0) {
        evaporationTime = 0;
      } else {
        evaporationTime =
            secondaryCloud / (3600 * evaporationRate * surfaceArea);
      }

      num toxiCosis = mapChemical["toxiCosis"];
      if (windSpeed > 0) {
        primaCloud = (coeficientB1 *
            pow((primaryCloud / (1000 * windSpeed * toxiCosis)), coeficientA));
      } else {
        primaCloud = (coeficientB1 *
            pow((primaryCloud / (1000 * 0.6 * toxiCosis)), coeficientA));
      }

      if (phis == 0) {
        secCloud = 0;
      } else if (phis == 1 && evaporationTime > 24) {
        secCloud = coeficientB2 *
            pow(24, -0.5) *
            pow((secondaryCloud / (1000 * windSpeed * toxiCosis)), coeficientA);
      } else {
        secCloud = coeficientB2 *
            pow(evaporationTime, -0.5) *
            pow((secondaryCloud / (1000 * windSpeed * toxiCosis)), coeficientA);
      }

      if (vert == -0.15 && prob == 0.5) {
        angleF2 = 20;
      } else if (vert == -0.15 && prob == 0.75) {
        angleF2 = 35;
      } else if (vert == -0.15 && prob == 0.9) {
        angleF2 = 50;
      } else if (vert == 0 && prob == 0.5 && evaporationTime < 6) {
        angleF2 = 15;
      } else if (vert == 0 && prob == 0.75 && evaporationTime < 6) {
        angleF2 = 25;
      } else if (vert == 0 && prob == 0.9 && evaporationTime < 6) {
        angleF2 = 40;
      } else if (vert == 0 &&
          prob == 0.5 &&
          evaporationTime >= 6 &&
          evaporationTime < 12) {
        angleF2 = 22;
      } else if (vert == 0 &&
          prob == 0.75 &&
          evaporationTime >= 6 &&
          evaporationTime < 12) {
        angleF2 = 37;
      } else if (vert == 0 &&
          prob == 0.9 &&
          evaporationTime >= 6 &&
          evaporationTime < 12) {
        angleF2 = 52;
      } else if (vert == 0 && prob == 0.75 && evaporationTime >= 12) {
        angleF2 = 50;
      } else if (vert == 0 && prob == 0.9 && evaporationTime >= 12) {
        angleF2 = 70;
      } else if (vert == 0 && prob == 0.5 && evaporationTime >= 12) {
        angleF2 = 30;
      } else if (vert == 0.15 && prob == 0.5) {
        angleF2 = 12;
      } else if (vert == 0.15 && prob == 0.75) {
        angleF2 = 20;
      } else {
        angleF2 = 30;
      }

      areaAccident = 3.1415 * pow(radiusAccident, 2);

      double coefficient = context.watch<GetCoefficient>().getCoefficient;
      if (primaCloud > 0) {
        primaryDepth = (coefficient * primaCloud);
      } else {
        primaryDepth = 0;
      }

      if (secCloud > 0) {
        secondaryDepth = (coefficient * secCloud);
      } else {
        secondaryDepth = 0;
      }

      if (primaryDepth > secondaryDepth) {
        globalDepth = (primaryDepth + radiusAccident);
      } else if (primaryDepth < secondaryDepth) {
        globalDepth = (secondaryDepth + radiusAccident);
      } else {
        globalDepth = 0;
      }

      areaZMHZ = 3.1415 * pow(globalDepth, 2);

      if (primaryDepth == 0) {
        areaFirst = 0;
      } else {
        areaFirst = pow((primaryDepth + radiusAccident), 2) * angleF1 / 60;
      }

      if (secondaryDepth == 0) {
        areaSecond = 0;
      } else {
        areaSecond = pow((secondaryDepth + radiusAccident), 2) * angleF2 / 60;
      }

      if (primaryDepth == 0) {
        areaPZHZ = 0;
      }
      if (primaryDepth > secondaryDepth) {
        areaPZHZ = 3.1415 *
            ((pow(radiusAccident, 2) * (180 - angleF2) / 180) +
                (pow((primaryDepth + radiusAccident), 2) * angleF1 / 180) +
                (pow((secondaryDepth + radiusAccident), 2) *
                    (angleF2 - angleF1) /
                    180));
      } else {
        areaPZHZ = 3.1415 *
            ((pow(radiusAccident, 2) * (180 - angleF2) / 180) +
                (pow((secondaryDepth + radiusAccident), 2) * angleF2 / 180));
      }
      return 0;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Результати розрахунків')),
      drawer: buildDrawer(context, ResultsChemicalHazard.route),
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
                            listChemicel().toStringAsFixed(3),
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
                              child: const Text("Радіус аварії Ra (км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(radiusAccident.toStringAsFixed(3),
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
                              child: const Text("Площа аварії Sa (кв.км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(areaAccident.toStringAsFixed(3),
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
                                  "Глибина поширення первинної хмари Г1 (км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(primaryDepth.toStringAsFixed(3),
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
                                  "Глибина поширення вторинної хмари Г2 (км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(secondaryDepth.toStringAsFixed(3),
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
                                  "Глибина зони хімічного забруднення Г (км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(globalDepth.toStringAsFixed(3),
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
                              child: const Text("Площа ЗМХЗ Sзмхз (кв.км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(areaZMHZ.toStringAsFixed(3),
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
                                  "Площа первинної хмари S1 (кв.км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(areaFirst.toStringAsFixed(3),
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
                                  "Площа вторинної хмари S2 (кв.км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(areaSecond.toStringAsFixed(3),
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
                              child: const Text("Площа ПЗХЗ Sпмхз (кв.км)",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              child: Text(areaPZHZ.toStringAsFixed(3),
                                  textScaleFactor: 1)),
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
                  context.read<GetAreaFirst>().changeAreaFirst(areaFirst);
                  context.read<GetAreaSecond>().changeAreaSecond(areaSecond);
                  context.read<GetAreaPZHZ>().changeAreaPZHZ(areaPZHZ);
                  context.read<GetAnglF1>().changeAnglF1(angleF1);
                  context.read<GetAnglF2>().changeAnglF2(angleF2);
                  context
                      .read<GetRadiusAccident>()
                      .changeRadiusAccident(radiusAccident);
                  context
                      .read<GetPrimaryDepth>()
                      .changePrimaryDepth(primaryDepth);
                  context
                      .read<GetSecondaryDepth>()
                      .changeSecondaryDepth(secondaryDepth);
                  context.read<GetGlobalDepth>().changeGlobalDepth(globalDepth);
                  context
                      .read<GetEvaporationTime>()
                      .changeEvaporationTime(globalDepth);
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(Icons.settings),
                label: const Text('Клацніть, щоб нанести показники на мапу'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
