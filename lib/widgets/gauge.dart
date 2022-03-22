import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Represents MyHomePage class
class GaugeApp extends StatefulWidget {
  /// Creates the instance of GaugeApp
  final String title;
  final double temp;
  GaugeApp(this.title, this.temp);

  @override
  _GaugeAppState createState() => _GaugeAppState();
}

class _GaugeAppState extends State<GaugeApp> {
  @override
  Widget build(BuildContext context) {
    // String temp;
    return Container(
      margin: EdgeInsets.all(10),
      width: 300,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), //color of shadow
              spreadRadius: 3, //spread radius
              blurRadius: 10, // blur radius
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: SfRadialGauge(
          title: GaugeTitle(
              text: widget.title,
              textStyle:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 50,
                minorTickStyle: const MinorTickStyle(
                    length: 0.05,
                    lengthUnit: GaugeSizeUnit.factor,
                    thickness: 1.5),
                majorTickStyle: const MajorTickStyle(
                    length: 0.1,
                    lengthUnit: GaugeSizeUnit.factor,
                    thickness: 1.5),
                minorTicksPerInterval: 5,
                radiusFactor: 0.95,
//ticksPosition: ElementsPosition.outside,
                labelsPosition: ElementsPosition.outside,
                axisLineStyle: AxisLineStyle(thickness: 15),
                //thicknessUnit: GaugeSizeUnit.factor, color: Colors.deepPurple,
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 30,
                    color: Colors.green,
                    startWidth: 10,
                    endWidth: 10,

                    // sizeUnit: GaugeSizeUnit.factor,
                  ),
                  GaugeRange(
                    startValue: 30,
                    endValue: 50,
                    color: Colors.orange,
                    startWidth: 10,
                    endWidth: 10,

                    // sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                      value: widget.temp,
                      needleStartWidth: 1,
                      enableAnimation: true,
                      tailStyle: TailStyle(
                          length: 0.2,
                          width: 4,
                          lengthUnit: GaugeSizeUnit.factor),
                      needleEndWidth: 4,
                      needleLength: 0.6,
                      lengthUnit: GaugeSizeUnit.factor,
                      knobStyle: KnobStyle(
                        knobRadius: 0.05,
                        sizeUnit: GaugeSizeUnit.factor,
                      ))
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                          child: Text(widget.temp.toString(),
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold))),
                      angle: 90,
                      positionFactor: .7)
                ])
          ]),
    );
  }
}
