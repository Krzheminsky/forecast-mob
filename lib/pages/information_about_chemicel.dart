import 'package:flutter/material.dart';
import 'package:forecast/widgets/drawer.dart';
import 'package:forecast/pages/data.dart' as data;
import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';

class InformationAboutChemikel extends StatelessWidget {
  static const String route = 'InformationAboutChemikel';
  const InformationAboutChemikel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nameChimical = context.watch<GetNameChemical>().getName;
    Map<String, dynamic> chemicall = data.chemical[nameChimical];
    String informationNHR = chemicall["nhr"];

    return Scaffold(
      appBar: AppBar(title: const Text('Інформація про хімічну речовину')),
      drawer: buildDrawer(context, route),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 0.0, top: 20.0, right: 20.0),
                  child: Text(informationNHR)),
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
                label: const Text('Перейти до мапи'),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
