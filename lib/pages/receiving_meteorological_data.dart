import 'package:flutter/material.dart';
import 'package:forecast/widgets/drawer.dart';

class ReceivingMeteorologicalData extends StatelessWidget {
  static const String route = 'ReceivingMeteorologicalData';
  const ReceivingMeteorologicalData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Поточні метеодані')),
      drawer: buildDrawer(context, route),
      body: SafeArea(
        child: Center(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Вихідні дані'),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(Icons.settings),
              label: const Text('Перейти на головну'),
            ),
          ],
        )),
      ),
    );
  }
}
