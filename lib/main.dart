import 'package:flutter/material.dart';

import 'package:forecast/pages/home.dart';
import 'package:forecast/pages/enter_data_chemicals.dart';
import 'package:forecast/pages/results_chemical_hazard.dart';
import 'package:forecast/pages/enter_data_possible_loses.dart';
import 'package:forecast/pages/result_possible_losses.dart';
import 'package:forecast/pages/information_about_chemicel.dart';
import 'package:forecast/pages/receiving_meteorological_data.dart';
import 'package:forecast/pages/about_forecast.dart';
import 'package:provider/provider.dart';
import 'calculate/data_calculate.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetNameChemical>(
          create: (context) => GetNameChemical(),
        ),
        ChangeNotifierProvider<GetVerticalStability>(
          create: (context) => GetVerticalStability(),
        ),
        ChangeNotifierProvider<GetPhisicalStat>(
          create: (context) => GetPhisicalStat(),
        ),
        ChangeNotifierProvider<GetProbability>(
          create: (context) => GetProbability(),
        ),
        ChangeNotifierProvider<GetEmountNHR>(
          create: (context) => GetEmountNHR(),
        ),
        ChangeNotifierProvider<GetWindSpeed>(
          create: (context) => GetWindSpeed(),
        ),
        ChangeNotifierProvider<GetTemperature>(
          create: (context) => GetTemperature(),
        ),
        ChangeNotifierProvider<GetCoefficient>(
          create: (context) => GetCoefficient(),
        ),
        ChangeNotifierProvider<GetPalletHeight>(
          create: (context) => GetPalletHeight(),
        ),
        ChangeNotifierProvider<GetWindDirection>(
          create: (context) => GetWindDirection(),
        ),
        ChangeNotifierProvider<GetAnglF1>(
          create: (context) => GetAnglF1(),
        ),
        ChangeNotifierProvider<GetAnglF2>(
          create: (context) => GetAnglF2(),
        ),
        ChangeNotifierProvider<GetRadiusAccident>(
          create: (context) => GetRadiusAccident(),
        ),
        ChangeNotifierProvider<GetPrimaryDepth>(
          create: (context) => GetPrimaryDepth(),
        ),
        ChangeNotifierProvider<GetSecondaryDepth>(
          create: (context) => GetSecondaryDepth(),
        ),
        ChangeNotifierProvider<GetGlobalDepth>(
          create: (context) => GetGlobalDepth(),
        ),
        ChangeNotifierProvider<GetTimeSinceAccident>(
          create: (context) => GetTimeSinceAccident(),
        ),
        ChangeNotifierProvider<GetDistanceToTheObject>(
          create: (context) => GetDistanceToTheObject(),
        ),
        ChangeNotifierProvider<GetPopulationDensity>(
          create: (context) => GetPopulationDensity(),
        ),
        ChangeNotifierProvider<GetAffectedArea>(
          create: (context) => GetAffectedArea(),
        ),
        ChangeNotifierProvider<GetProtectionFactor>(
          create: (context) => GetProtectionFactor(),
        ),
        ChangeNotifierProvider<GetEvaporationTime>(
          create: (context) => GetEvaporationTime(),
        ),
        ChangeNotifierProvider<GetAreaFirst>(
          create: (context) => GetAreaFirst(),
        ),
        ChangeNotifierProvider<GetAreaSecond>(
          create: (context) => GetAreaSecond(),
        ),
        ChangeNotifierProvider<GetAreaPZHZ>(
          create: (context) => GetAreaPZHZ(),
        ),
        ChangeNotifierProvider<GetTappedPoints>(
          create: (context) => GetTappedPoints(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Forecast',
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          EnterDataChemicals.route: (context) => const EnterDataChemicals(),
          ResultsChemicalHazard.route: (context) =>
              const ResultsChemicalHazard(),
          EnterDataPossibleLosses.route: (context) =>
              const EnterDataPossibleLosses(),
          ResultPossibleLosses.route: (context) => const ResultPossibleLosses(),
          InformationAboutChemikel.route: (context) =>
              const InformationAboutChemikel(),
          ReceivingMeteorologicalData.route: (context) =>
              ReceivingMeteorologicalData(),
          AboutForecast.route: (context) => const AboutForecast(),
        },
      ),
    );
  }
}
