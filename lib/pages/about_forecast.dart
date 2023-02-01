// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:forecast/widgets/drawer.dart';

class AboutForecast extends StatelessWidget {
  static const String route = 'AboutForecast';
  const AboutForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Про застосунок Forecast')),
      drawer: buildDrawer(context, route),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                  child: const Text(
                    'Слава Україні! Героям Слава!',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                  child:
                      const Text("Шановні співвітчизники, доброго часу доби!")),
              Container(
                margin: const EdgeInsets.only(
                    left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                child: const Text(
                    "     Мобільний застосунок Forecast - розроблено з метою допомоги фахівцям з цивільного захисту та громадянам оперативно, швидко визначити основні загрози, які можуть виникнути при аваріях на хімічно-небезпечних об'єктах. \n     Автор наполягає, що засосунок Forecast НЕ Є ОФІЦІЙНИМ ДЖЕРЕЛОМ отримання розрахункових даних, а лише допомогає оперативно розрахувати та візуалізувати на карті місце та район аварії, глибину поширення первинної та вторинної хмар, площу ЗМХЗ та ПЗХЗ.\n     У використанні застосунок дуже простий:\n     - заповнюємо показники на вкладці 'Вихідні дані';\n     - дивимося на результати розрахунків у одноіменній вкладці;\n     - переходимо до мапи та вибираємо (клацаємо пальцем) на місце аварії. Хоча це можно зробити і на початку :-)\n     - якщо потрібно, розраховуємо можливі втрати у відповідних вкладках.\n     При бажанні, Ви ще зможете знайти деякі цікавинки."),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                  child: const Text(
                    "З повагою, автор - Віктор Кржемінський.",
                    textAlign: TextAlign.left,
                  )),
              Container(
                margin: const EdgeInsets.only(
                    left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                child: const Text(
                    "     Якщо є пропозиції щодо покращання застосунку - пишіть: krzheminsky@ukr.net"),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 0.0, top: 10.0, right: 20.0),
                  child: const Text("Якби хто хотів підтримати проект:")),
              const Text("5168 7451 1577 2458"),
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
          ),
        ),
      ),
    );
  }
}
