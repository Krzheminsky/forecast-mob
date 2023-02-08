import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecast/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:forecast/pages/result_possible_losses.dart';

class EnterDataPossibleLosses extends StatefulWidget {
  static const String route = 'EnterDataPossibleLosses';
  const EnterDataPossibleLosses({Key? key}) : super(key: key);

  @override
  State<EnterDataPossibleLosses> createState() =>
      _EnterDataPossibleLossesState();
}

class _EnterDataPossibleLossesState extends State<EnterDataPossibleLosses> {
  @override
  Widget build(BuildContext context) {
    String startTimeSinceAccident = context
        .watch<GetTimeSinceAccident>()
        .getTimeSinceAccident
        .toStringAsFixed(0);
    String startDistanceToTheObject = context
        .watch<GetDistanceToTheObject>()
        .getDistanceToTheObject
        .toStringAsFixed(0);
    String startPopulationDensity = context
        .watch<GetPopulationDensity>()
        .getPopulationDensity
        .toStringAsFixed(0);
    String startAffectedArea =
        context.watch<GetAffectedArea>().getAffectedArea.toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(title: const Text('Розрахунок можливих втрат')),
      drawer: buildDrawer(context, EnterDataPossibleLosses.route),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  ],
                  initialValue: startTimeSinceAccident,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: const InputDecoration(
                    labelText: 'Час, з моменту аварії (хвилин)',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      context
                          .read<GetTimeSinceAccident>()
                          .changeTimeSinceAccident(double.parse(value));
                    }
                  },
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  ],
                  initialValue: startDistanceToTheObject,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: const InputDecoration(
                    labelText: 'Відстань від джерела до об\'єкта (км)',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      context
                          .read<GetDistanceToTheObject>()
                          .changeDistanceToTheObject(double.parse(value));
                    }
                  },
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  ],
                  initialValue: startPopulationDensity,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: const InputDecoration(
                    labelText: 'Щильність населення (осіб/кв.км)',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      context
                          .read<GetPopulationDensity>()
                          .changePopulationDensity(double.parse(value));
                    }
                  },
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    // TextInputFormatter.withFunction((oldValue, newValue) {
                    //   try {
                    //     final text = newValue.text;
                    //     if (text.isNotEmpty) double.parse(text);
                    //     return newValue;
                    //   } catch (e) {}
                    //   return oldValue;
                    // }),
                  ],
                  initialValue: startAffectedArea,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: const InputDecoration(
                    labelText: 'Площа ураженої території (кв.км)',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    // isCollapsed: true,
                  ),
                  onChanged: (value) {
                    if (double.tryParse(value) != null) {
                      context
                          .read<GetAffectedArea>()
                          .changeAffectedArea(double.parse(value));
                    }
                  },
                )),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(255, 75, 74, 74),
                        width: 1,
                      )),
                  child: SfSlider(
                    value: context
                        .watch<GetProtectionFactor>()
                        .getProtectionFactor,
                    min: 0.0,
                    max: 1.0,
                    showLabels: true,
                    interval: 0.25,
                    showTicks: true,
                    enableTooltip: true,
                    // ignore: non_constant_identifier_names
                    onChanged: (dynamic NewValue) => context
                        .read<GetProtectionFactor>()
                        .changeProtectionFactor(NewValue),
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 4,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      " Коефіціент захищеності ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 73, 73, 73),
                        backgroundColor: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ResultPossibleLosses();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Перейти до результатів'),
            ),
          ],
        )),
      ),
    );
  }
}
