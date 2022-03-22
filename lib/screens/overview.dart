import 'package:flutter/material.dart';
import 'package:udhyog/models/press.dart';
import 'package:udhyog/providers/press.dart';
import 'package:udhyog/widgets/newPress.dart';
import 'package:udhyog/widgets/gauge.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Press> press = PressProvider('', [
      Press(
        pressId: 1,
        partCount: 1.2,
        pressName: 'Press 1',
        blockTemp: '23',
        clientId: 1,
        createdAt: DateTime.now(),
        hoseTemp: 24,
        pressType: 'automatic',
        tankLowerTemp: 24,
        tankTopTemp: 25,
        timer: 123,
      ),
      Press(
        pressId: 2,
        partCount: 1.2,
        pressName: 'Press 2',
        blockTemp: '23',
        clientId: 1,
        createdAt: DateTime.now(),
        hoseTemp: 24,
        pressType: 'automatic',
        tankLowerTemp: 24,
        tankTopTemp: 25,
        timer: 123,
      ),
      Press(
        pressId: 3,
        partCount: 1.2,
        pressName: 'Press 3',
        blockTemp: '23',
        clientId: 1,
        createdAt: DateTime.now(),
        hoseTemp: 24,
        pressType: 'automatic',
        tankLowerTemp: 24,
        tankTopTemp: 25,
        timer: 123,
      ),
    ]).presses;
    Color backG = Color.fromARGB(174, 230, 231, 233);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(8),
            color: backG,
            child: ListView.builder(
              itemBuilder: (ctx, index) => Container(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.topLeft,
                        child:
                            // Text(
                            //   "Press",
                            //   style: TextStyle(
                            //       fontSize: 18, fontWeight: FontWeight.bold),
                            // )
                            Text('${press[index].pressName}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                    Container(
                        margin: EdgeInsets.all(8),
                        width: double.maxFinite,
                        height: 300,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GaugeApp(
                                'Lower Tank Temp', press[index].tankLowerTemp),
                            GaugeApp(
                                'Higher Tank Temp',
                                double.parse(
                                    press[index].tankTopTemp.toString())),
                            GaugeApp('Hose Temp', press[index].hoseTemp),
                            GaugeApp('Block Temp',
                                double.parse(press[index].blockTemp)),
                          ],
                        )),
                  ],
                ),
              ),
              itemCount: press.length,
            )));
  }
}
