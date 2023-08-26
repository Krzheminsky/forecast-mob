import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecast/widgets/drawer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:forecast/pages/data.dart' as data;
import 'package:forecast/pages/results_chemical_hazard.dart';

import 'package:provider/provider.dart';
import 'package:forecast/calculate/data_calculate.dart';

class EnterDataChemicals extends StatefulWidget {
  static const String route = 'EnterDataChemicals';
  const EnterDataChemicals({Key? key}) : super(key: key);

  @override
  State<EnterDataChemicals> createState() => _EnterDataChemicalsState();
}

class _EnterDataChemicalsState extends State<EnterDataChemicals> {
  addHim() {
    List him = (data.chemicalSubstance.map((e) => e["name"]).toList());
    for (var i = 1; i < him.length; i++) {
      nameChemical.add(him[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    addHim();
  }

  var nameChemical = ['Хлор'];

  var verticalStabilit = [
    'Ізотермія',
    'Конвекція',
    'Інверсія',
  ];

  var phisicalStat = [
    'Рідкий',
    'Газоподібний',
  ];

  var probabilit = [
    'Довгострокове',
    'Аварійне',
    'Часткова наявність даних',
  ];

  var windDirection = 0;

  // ********************** Додаємо дані до розрахунку комплексного показника

  var typeOfVegetation = [
    'Лісиста',
    'Лісисто-степова',
    'Степова',
    'Напівпустельна',
  ];

  var relief = [
    'Рівнинний',
    'Рівнинно-хвилястий',
    'Рівнинно-горбистий',
    'Горбисто-балочний',
    'Горбистий',
    'Передгір’я',
  ];

  var season = [
    'Літо',
    'Зима',
  ];

  var typeOfForest = [
    'Хвойні',
    'Змішані'
  ]; //визначаємо в залежності від typeOfVegetation

  var valueForest = 'Хвойні';

//   export const typeOfVegetation = [
//     { name: 'Лісиста', typeOfForest: ['Хвойні', 'Змішані',] },
//     { name: 'Лісисто-степова', typeOfForest: ['Хвойні', 'Листяні',] },
//     { name: 'Степова', typeOfForest: ['Не визначається'] },
//     { name: 'Напівпустельна', typeOfForest: ['Не визначається'] },

// ]

  // ********************** Додаємо дані до розрахунку комплексного показника

  @override
  Widget build(BuildContext context) {
    var vegetation = context.watch<GetTypeOfVegetation>().getTypeOfVegetationf;

    if (vegetation == 'Лісиста') {
      typeOfForest = ['Хвойні', 'Змішані'];
      valueForest = 'Хвойні';
    } else if (vegetation == 'Лісисто-степова') {
      typeOfForest = [
        'Хвойні',
        'Листяні',
      ];
      valueForest = 'Хвойні';
    } else {
      typeOfForest = ['Не визначається'];
      valueForest = 'Не визначається';
    }

    String startValue =
        context.watch<GetEmountNHR>().getEmountNHR.toStringAsFixed(0);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Вихідні дані')),
      drawer: buildDrawer(context, EnterDataChemicals.route),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 15.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value: context.watch<GetNameChemical>().getName,
                items: nameChemical.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (newValue) => context
                    .read<GetNameChemical>()
                    .changeName(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Вибір хімічної речовини',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value:
                    context.watch<GetVerticalStability>().getVerticalStability,
                items: verticalStabilit.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) => context
                    .read<GetVerticalStability>()
                    .changeVerticalStability(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Ступінь вертикальної стійкості',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value: context.watch<GetPhisicalStat>().getPhisicalStat,
                items: phisicalStat.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) => context
                    .read<GetPhisicalStat>()
                    .changePhisicalStat(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Агрегатний стан НХР',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value: context.watch<GetProbability>().getProbability,
                items: probabilit.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) => context
                    .read<GetProbability>()
                    .changeProbability(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Характер прогнозування',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  ],
                  initialValue: startValue,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  decoration: const InputDecoration(
                    labelText: 'Кількість НХР в ємності (кг)',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 10.0, bottom: 8.0, top: 8.0, right: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    isCollapsed: true,
                  ),
                  onChanged: (rrr) {
                    if (double.tryParse(rrr) != null) {
                      context
                          .read<GetEmountNHR>()
                          .changeEmountNHR(double.parse(rrr));
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
                    value: context.watch<GetWindSpeed>().getWindSpeed,
                    min: 0.0,
                    max: 30.0,
                    showLabels: true,
                    interval: 5,
                    showTicks: true,
                    enableTooltip: true,
                    // ignore: non_constant_identifier_names
                    onChanged: (dynamic NewValue) {
                      context.read<GetWindSpeed>().changeWindSpeed(NewValue);
                    },
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 4,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      " Швидкість вітру (м/с) ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 73, 73, 73),
                        backgroundColor: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
                    value: context.watch<GetTemperature>().getTemperature,
                    min: -30.0,
                    max: 40.0,
                    showLabels: true,
                    interval: 10,
                    showTicks: true,
                    enableTooltip: true,
                    // ignore: non_constant_identifier_names
                    onChanged: (dynamic NewValue) => context
                        .read<GetTemperature>()
                        .changeTemperature(NewValue),
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 4,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      " Температура повітря (С) ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 73, 73, 73),
                        backgroundColor: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Stack(
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.only(
            //           left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
            //       padding: const EdgeInsets.all(0),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           color: Colors.white,
            //           border: Border.all(
            //             color: const Color.fromARGB(255, 75, 74, 74),
            //             width: 1,
            //           )),
            //       child: SfSlider(
            //         value: context.watch<GetCoefficient>().getCoefficient,
            //         min: 0.0,
            //         max: 1.0,
            //         showLabels: true,
            //         interval: 0.1,
            //         showTicks: true,
            //         enableTooltip: true,
            //         // ignore: non_constant_identifier_names
            //         onChanged: (dynamic NewValue) {
            //           setState(() {
            //             if (NewValue < 0.05) {
            //               context
            //                   .read<GetCoefficient>()
            //                   .changeCoefficient(0.05);
            //             } else {
            //               context
            //                   .read<GetCoefficient>()
            //                   .changeCoefficient(NewValue);
            //             }
            //           });
            //         },
            //       ),
            //     ),
            //     Positioned(
            //       left: 17,
            //       top: 4,
            //       // ignore: avoid_unnecessary_containers
            //       child: Container(
            //         child: const Text(
            //           " Коефіцієнт впливу місцевості ",
            //           textAlign: TextAlign.left,
            //           style: TextStyle(
            //             color: Color.fromARGB(255, 73, 73, 73),
            //             backgroundColor: Colors.white,
            //             fontSize: 11,
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
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
                    value: context.watch<GetPalletHeight>().getPalletHeight,
                    min: 0.0,
                    max: 3.0,
                    showLabels: true,
                    interval: 0.5,
                    showTicks: true,
                    enableTooltip: true,
                    // ignore: non_constant_identifier_names
                    onChanged: (dynamic NewValue) => context
                        .read<GetPalletHeight>()
                        .changePalletHeight(NewValue),
                  ),
                ),
                Positioned(
                  left: 17,
                  top: 4,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      " Висота піддону (м), 0 - якщо відсутній ",
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
            Container(
                margin: const EdgeInsets.only(
                    left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                child: const Center(
                  child: Text(
                    'Визначення коефіцієнту впливу місцевості',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 9, 78, 134)),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 20.0, bottom: 0.0, top: 0, right: 20.0),
                child: const Center(
                  child: Text(
                    "обов'язково оберіть усі категорії!",
                    style: TextStyle(
                        fontSize: 10, color: Color.fromARGB(255, 255, 0, 0)),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value: context.watch<GetSeason>().getSeason,
                items: season.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) =>
                    context.read<GetSeason>().changeSeason(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Пора року',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value: context.watch<GetRelief>().getRelief,
                items: relief.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) =>
                    context.read<GetRelief>().changeRelief(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Вид рельєфу',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value:
                    context.watch<GetTypeOfVegetation>().getTypeOfVegetationf,
                items: typeOfVegetation.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) => context
                    .read<GetTypeOfVegetation>()
                    .changeTypeOfVegetation(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Вид рослинності',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10.0, bottom: 0.0, top: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10.0),
                value: valueForest,
                items: typeOfForest.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) => context
                    .read<GetTypeOfForest>()
                    .changeTypeOfForest(newValue.toString()),
                decoration: const InputDecoration(
                  labelText: 'Тип лісу',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 10.0, bottom: 5.0, top: 5.0, right: 10.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                dropdownColor: const Color.fromARGB(255, 227, 222, 235),
              ),
            ),
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      width: 190,
                      margin: const EdgeInsets.only(
                          left: 10.0, bottom: 0.0, top: 15.0, right: 10.0),
                      child: SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                            size: 80,
                            angleRange: 360,
                            startAngle: 270,
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 6,
                              trackWidth: 6,
                              handlerSize: 10,
                            ),
                            customColors: CustomSliderColors(
                              trackColor: Colors.blue,
                              progressBarColor: Colors.blue,
                              dotColor: Colors.red,
                            ),
                            infoProperties: InfoProperties(
                              modifier: percentageModifier,
                              mainLabelStyle: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )),
                        min: 0,
                        max: 360,
                        initialValue:
                            context.watch<GetWindDirection>().getWindDirection,
                        onChange: (double value) => context
                            .read<GetWindDirection>()
                            .changeWindDirection(value),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 20,
                  top: 35,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      "Напрямок",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        // color: Color.fromARGB(255, 73, 73, 73),
                        // backgroundColor: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 55,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      "вітру",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        // color: Color.fromARGB(255, 73, 73, 73),
                        // backgroundColor: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
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
                      return const ResultsChemicalHazard();
                    },
                  ),
                );
                // print(context.watch<GetTypeOfForest>().getTypeOfForest);
              },
              icon: const Icon(Icons.settings),
              label: const Text('Перейти до результатів'),
            ),
          ],
        ),
      )),
    );
  }
}

String percentageModifier(double value) {
  final roundedValue = value.ceil().toInt().toString();
  return '$roundedValue°';
}
