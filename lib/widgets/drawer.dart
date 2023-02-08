import 'package:flutter/material.dart';
import 'package:forecast/pages/enter_data_chemicals.dart';
import 'package:forecast/pages/results_chemical_hazard.dart';
import 'package:forecast/pages/home.dart';
import 'package:forecast/pages/enter_data_possible_loses.dart';
import 'package:forecast/pages/result_possible_losses.dart';
import 'package:forecast/pages/information_about_chemicel.dart';
import 'package:forecast/pages/receiving_meteorological_data.dart';
import 'package:forecast/pages/about_forecast.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    backgroundColor: Colors.grey[200],
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 64.0,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Center(
              child: Text('Прогнозування наслідків аварій на ХНО',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          child: ListTile(
            // contentPadding: null,
            title: const Text('Головна'),
            subtitle: const Text(
              'Мапа, нанесення зон ураження',
              style: TextStyle(fontSize: 10),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            //leading: Icon(Icons.map_outlined),
            dense: true,
            // enabled: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 6,
          child: ListTile(
            title: const Text('Вихідні дані'),
            subtitle: const Text(
              'Внесення відомостей щодо НХР',
              style: TextStyle(fontSize: 10),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const EnterDataChemicals();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 6,
          child: ListTile(
            title: const Text('Результати'),
            subtitle: const Text(
              'Результати розрахунків хімічної небезпеки',
              style: TextStyle(fontSize: 10),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ResultsChemicalHazard();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 6,
          child: ListTile(
            title: const Text('Розрахунок втрат'),
            subtitle: const Text(
              'Розрахунок можливих втрат населення',
              style: TextStyle(fontSize: 10),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const EnterDataPossibleLosses();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 6,
          child: ListTile(
            title: const Text('Можливі втрати'),
            subtitle: const Text(
              'Можливі втрати населення',
              style: TextStyle(fontSize: 10),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ResultPossibleLosses();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 6,
          child: ListTile(
            title: const Text('Інформація про НХР'),
            subtitle: const Text(
              'Довідкова інформація про хімічну речовину',
              style: TextStyle(fontSize: 10),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const InformationAboutChemikel();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          elevation: 6,
          child: ListTile(
            title: const Text('Поточні метеодані'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ReceivingMeteorologicalData();
                  },
                ),
              );
            },
          ),
        ),
        Card(
          color: Colors.yellow[200],
          elevation: 6,
          child: ListTile(
            title: const Text('Про FORECAST'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AboutForecast();
                  },
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
