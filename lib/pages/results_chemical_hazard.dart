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
    double coefA = 0;
    double coefB1 = 0;
    double coefB2 = 0;
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
    double complexIndicator = 0;
    double terrainInfluenceCoefficient = 0;
    double amountEvaporated = 0;

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

// add change in formulas coefA coefB1 coefB2:
      if (nameChimical == 'Хлор') {
        if (vertical != 'конвекція') {
          coefA = (0.57 * exp(0.86 * vert));
        } else {
          coefA = (0.57 * exp(0.86 * vert));
        }
      } else if (nameChimical == 'Аміак') {
        if (vertical != 'конвекція') {
          coefA = (0.57 * exp(0.86 * vert * 1.009));
        } else {
          coefA = (0.57 * exp(0.86 * vert * 0.88));
        }
      } else {
        coefA = (0.57 * exp(0.86 * vert));
      }

      if (nameChimical == 'Хлор') {
        if (vertical != 'конвекція') {
          coefB1 = (17.43 * exp(6.96 * vert * 0.936));
        } else {
          coefB1 = (15.4 * exp(6.96 * vert * 0.89));
        }
      } else if (nameChimical == 'Аміак') {
        if (vertical != 'конвекція') {
          coefB1 = (16.3 * exp(6.96 * vert * 1.006));
        } else {
          coefB1 = (15.4 * exp(6.96 * vert * 0.91));
        }
      } else {
        coefB1 = (15.4 * exp(6.96 * vert));
      }

      if (nameChimical == 'Хлор') {
        coefB2 = (16.84 * exp(6.87 * vert));
      } else if (nameChimical == 'Аміак') {
        coefB2 = (16.84 * exp(6.87 * vert));
      } else {
        coefB2 = (16.84 * exp(6.87 * vert));
      }
      // double coefA = (0.57 * exp(0.86 * vert));
      coeficientA = coefA;
      // double coefB1 = (15.4 * exp(6.96 * vert));
      coeficientB1 = coefB1;
      // double coefB2 = (16.84 * exp(6.87 * vert));
      coeficientB2 = coefB2;

      // add change in formulas coefA coefB1 coefB2:

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

      // correcting diameterArea
      if (amountNHR <= 2000000) {
        if (palletHeight == 0) {
          diameterArea = 5.04 * (sqrt((amountNHR - primaryCloud) / density));
        } else {
          diameterArea = 1.22 * (sqrt((amountNHR - primaryCloud) / density));
        }
      } else {
        if (palletHeight == 0) {
          diameterArea = 5.04 * (sqrt((amountNHR - primaryCloud) / density));
        } else {
          diameterArea = (1.22 / sqrt(palletHeight)) *
              (sqrt((amountNHR - primaryCloud) / density));
        }
      }
      // correcting diameterArea

      double surfaceArea = 3.1415 * diameterArea * diameterArea / 4;

      double molWeight = mapChemical["molWeight"];
      if (phis == 0) {
        evaporationRate = 0;
      } else {
        evaporationRate = (0.041 *
            ((windSpeed * molWeight) /
                (pow(diameterArea, 0.14) * (airTemperature + 273.15))) *
            exp((vaporisation * molWeight / 8.31) *
                ((1 / (boilingPoint + 273.15)) -
                    (1 / (airTemperature + 273.15)))));
      }

      if (phis == 0) {
        evaporationTime = 0;
      } else {
        evaporationTime =
            secondaryCloud / (3600 * evaporationRate * surfaceArea);
      }

      num toxiCosis = mapChemical["toxiCosis"];

      // correcting formula primaCloud

      if (windSpeed > 0) {
        if (nameChimical == 'Хлор') {
          if (windSpeed <= 1.5) {
            primaCloud = (coeficientB1 *
                pow((primaryCloud / (1000 * windSpeed * toxiCosis)),
                    coeficientA));
          } else {
            primaCloud = 1.087 *
                (coeficientB1 *
                    pow((primaryCloud / (1000 * windSpeed * toxiCosis)),
                        coeficientA));
          }
        } else if (nameChimical == 'Хлорціан') {
          primaCloud = 1.483 *
              (coeficientB1 *
                  pow((primaryCloud / (1000 * windSpeed * toxiCosis)),
                      coeficientA));
        } else {
          primaCloud = (coeficientB1 *
              pow((primaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA));
        }
      } else {
        primaCloud = (coeficientB1 *
            pow((primaryCloud / (1000 * 0.6 * toxiCosis)), coeficientA));
      }
      // corrective formula primaCloud

      // add amountEvaporated
      amountEvaporated = evaporationRate *
          24 *
          3600 *
          (3.14 * diameterArea * diameterArea / 4);
      // add amountEvaporated

      // correcting secCloud
      if (phis == 0) {
        secCloud = 0;
      } else if (phis == 1 && evaporationTime > 24) {
        if (nameChimical == 'Хлорпікрін') {
          secCloud = 0.244 *
              coeficientB2 *
              pow(24, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Аміак') {
          secCloud = 0.4333 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Хлор') {
          secCloud = 0.419243 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Формальдегід') {
          secCloud = 0.82836 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Сірчистий ангідрид') {
          secCloud = 0.61306 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Сірководень') {
          secCloud = 0.51813 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Миш'яковистий водень") {
          secCloud = 0.31646 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Бромоводень") {
          secCloud = 0.2561 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Бромометан") {
          secCloud = 0.7739 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Фтор") {
          secCloud = 0.00000179243 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else {
          secCloud = coeficientB2 *
              pow(24, -0.5) *
              pow((amountEvaporated / (windSpeed * toxiCosis)), coeficientA);
        }
      } else {
        if (nameChimical == 'Хлор') {
          secCloud = 0.419243 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Аміак') {
          secCloud = 0.4333 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Формальдегід') {
          secCloud = 0.82836 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Сірчистий ангідрид') {
          secCloud = 0.61306 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == 'Сірководень') {
          secCloud = 0.51813 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Миш'яковистий водень") {
          secCloud = 0.31646 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Бромоводень") {
          secCloud = 0.2561 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Бромометан") {
          secCloud = 0.7739 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else if (nameChimical == "Фтор") {
          secCloud = 0.00000179243 *
              coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        } else {
          secCloud = coeficientB2 *
              pow(evaporationTime, -0.5) *
              pow((secondaryCloud / (1000 * windSpeed * toxiCosis)),
                  coeficientA);
        }
      }
      // correcting secCloud

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

      // ********************************Вставити розрахунок коефіцієнту*****************

      String typeForest = context.watch<GetTypeOfForest>().getTypeOfForest;
      String relief = context.watch<GetRelief>().getRelief;
      String season = context.watch<GetSeason>().getSeason;
      String typeVegetation =
          context.watch<GetTypeOfVegetation>().getTypeOfVegetationf;

      if (season == 'Літо') {
        if (typeVegetation == 'Лісиста') {
          if (typeForest == 'Хвойні') {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.9;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 1.1;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 1.2;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 1.3;
            } else if (relief == 'Горбистий') {
              complexIndicator = 1.4;
            } else {
              complexIndicator = 1.6;
            }
          } else {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.6;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 0.8;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 0.9;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 0.9;
            } else if (relief == 'Горбистий') {
              complexIndicator = 1;
            } else {
              complexIndicator = 1.2;
            }
          }
        } else if (typeVegetation == 'Лісисто-степова') {
          if (typeForest == 'Хвойні') {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.6;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 0.8;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 1;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 1.1;
            } else if (relief == 'Горбистий') {
              complexIndicator = 1.2;
            } else {
              complexIndicator = 1.5;
            }
          } else {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.4;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 0.6;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 0.8;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 0.9;
            } else if (relief == 'Горбистий') {
              complexIndicator = 0.9;
            } else {
              complexIndicator = 1.1;
            }
          }
        } else if (typeVegetation == 'Степова') {
          if (relief == 'Рівнинний') {
            complexIndicator = 0.3;
          } else if (relief == 'Рівнинно-хвилястий') {
            complexIndicator = 0.4;
          } else if (relief == 'Рівнинно-горбистий') {
            complexIndicator = 0.7;
          } else if (relief == 'Горбисто-балочний') {
            complexIndicator = 0.8;
          } else if (relief == 'Горбистий') {
            complexIndicator = 0.8;
          } else {
            complexIndicator = 1;
          }
        } else {
          if (relief == 'Рівнинний') {
            complexIndicator = 0.1;
          } else if (relief == 'Рівнинно-хвилястий') {
            complexIndicator = 0.2;
          } else if (relief == 'Рівнинно-горбистий') {
            complexIndicator = 0.4;
          } else if (relief == 'Горбисто-балочний') {
            complexIndicator = 0.5;
          } else if (relief == 'Горбистий') {
            complexIndicator = 0.6;
          } else {
            complexIndicator = 0.8;
          }
        }
      } else {
        if (typeVegetation == 'Лісиста') {
          if (typeForest == 'Хвойні') {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.9;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 1.1;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 1.2;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 1.3;
            } else if (relief == 'Горбистий') {
              complexIndicator = 1.4;
            } else {
              complexIndicator = 1.6;
            }
          } else {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.4;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 0.6;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 0.7;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 1;
            } else if (relief == 'Горбистий') {
              complexIndicator = 0.9;
            } else {
              complexIndicator = 1.1;
            }
          }
        } else if (typeVegetation == 'Лісисто-степова') {
          if (typeForest == 'Хвойні') {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.5;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 0.7;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 0.8;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 0.9;
            } else if (relief == 'Горбистий') {
              complexIndicator = 1;
            } else {
              complexIndicator = 1.3;
            }
          } else {
            if (relief == 'Рівнинний') {
              complexIndicator = 0.2;
            } else if (relief == 'Рівнинно-хвилястий') {
              complexIndicator = 0.3;
            } else if (relief == 'Рівнинно-горбистий') {
              complexIndicator = 0.5;
            } else if (relief == 'Горбисто-балочний') {
              complexIndicator = 0.6;
            } else if (relief == 'Горбистий') {
              complexIndicator = 0.7;
            } else {
              complexIndicator = 1;
            }
          }
        } else if (typeVegetation == 'Степова') {
          if (relief == 'Рівнинний') {
            complexIndicator = 0.1;
          } else if (relief == 'Рівнинно-хвилястий') {
            complexIndicator = 0.2;
          } else if (relief == 'Рівнинно-горбистий') {
            complexIndicator = 0.4;
          } else if (relief == 'Горбисто-балочний') {
            complexIndicator = 0.5;
          } else if (relief == 'Горбистий') {
            complexIndicator = 0.6;
          } else {
            complexIndicator = 0.9;
          }
        } else {
          if (relief == 'Рівнинний') {
            complexIndicator = 0.05;
          } else if (relief == 'Рівнинно-хвилястий') {
            complexIndicator = 0.1;
          } else if (relief == 'Рівнинно-горбистий') {
            complexIndicator = 0.3;
          } else if (relief == 'Горбисто-балочний') {
            complexIndicator = 0.5;
          } else if (relief == 'Горбистий') {
            complexIndicator = 0.6;
          } else {
            complexIndicator = 0.8;
          }
        }
      }

      if (complexIndicator == 0.05) {
        terrainInfluenceCoefficient = 1;
      } else if (complexIndicator == 0.1) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.8;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.8;
        } else {
          terrainInfluenceCoefficient = 0.9;
        }
      } else if (complexIndicator == 0.2) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.5;
        } else {
          terrainInfluenceCoefficient = 0.6;
        }
      } else if (complexIndicator == 0.3) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.4;
        } else {
          terrainInfluenceCoefficient = 0.5;
        }
      } else if (complexIndicator == 0.4) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.3;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.4;
        } else {
          terrainInfluenceCoefficient = 0.5;
        }
      } else if (complexIndicator == 0.5) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.3;
        } else {
          terrainInfluenceCoefficient = 0.4;
        }
      } else if (complexIndicator == 0.6) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.3;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.3;
        } else {
          terrainInfluenceCoefficient = 0.4;
        }
      } else if (complexIndicator == 0.7) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.2;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.3;
        } else {
          terrainInfluenceCoefficient = 0.4;
        }
      } else if (complexIndicator == 0.8) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.2;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.3;
        } else {
          terrainInfluenceCoefficient = 0.4;
        }
      } else if (complexIndicator == 0.9) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.2;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.2;
        } else {
          terrainInfluenceCoefficient = 0.3;
        }
      } else if (complexIndicator == 1.0) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.1;
        } else if (vertical == 'ізотермія') {
          terrainInfluenceCoefficient = 0.2;
        } else {
          terrainInfluenceCoefficient = 0.3;
        }
      } else if (complexIndicator == 1.1) {
        if (vertical == 'конвекція') {
          terrainInfluenceCoefficient = 0.1;
        } else {
          terrainInfluenceCoefficient = 0.2;
        }
      } else if (complexIndicator == 1.2) {
        terrainInfluenceCoefficient = 0.1;
      } else if (complexIndicator == 1.3) {
        terrainInfluenceCoefficient = 0.1;
      } else {
        terrainInfluenceCoefficient = 0.05;
      }

      // ********************************Вставити розрахунок коефіцієнту*****************

      // double coefficient = context.watch<GetCoefficient>().getCoefficient;
      if (primaCloud > 0) {
        primaryDepth = (terrainInfluenceCoefficient * primaCloud);
      } else {
        primaryDepth = 0;
      }

      if (secCloud > 0) {
        secondaryDepth = (terrainInfluenceCoefficient * secCloud);
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
                                  "Коефіцієнт впливу місцевості Км",
                                  textScaleFactor: 0.95)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              // height: 24,
                              child: Text(
                                  terrainInfluenceCoefficient
                                      .toStringAsFixed(1),
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
                  context.read<GetZoom>().changeZoom(10);
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
