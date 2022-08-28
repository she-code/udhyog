import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io' as file;
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as charts_text;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  GlobalKey _chartKey = GlobalKey();
  // RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
  List<Series<TempVal, DateTime>>? _seriesChartData;
  _generateData() {
    var chartData = [
      TempVal(time: DateTime(2017, 9, 19), value: 5),
      TempVal(time: DateTime(2017, 9, 26), value: 25),
      TempVal(time: DateTime(2017, 10, 3), value: 100),
      TempVal(time: DateTime(2017, 10, 10), value: 75),
    ];
    _seriesChartData?.add(Series(
        data: chartData,
        domainFn: (TempVal val, _) => val.time,
        measureFn: (TempVal val, _) => val.value,
        id: "Daily data",
        colorFn: (TempVal val, _) => ColorUtil.fromDartColor(Colors.orange)
        //labelAccessorFn: (TempVal row, _) => '${row.value}'
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesChartData = <Series<TempVal, DateTime>>[];
    _generateData();
  }

  // void download() async {
  //   final boundary =
  //       _chartKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  //   final image = await boundary?.toImage();
  //   final byteData = await image?.toByteData(format: ImageByteFormat.png);
  //   final imageBytes = byteData?.buffer.asUint8List();

  //   if (imageBytes != null) {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath =
  //         await file.File('${directory.path}/container_image.png').create();
  //     await imagePath.writeAsBytes(imageBytes);
  //   }
  // }

  // Future<void> _capturePng() async {
  //   final RenderRepaintBoundary boundary =
  //       _chartKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  //   final image = await boundary.toImage();
  //   final byteData = await image.toByteData(format: ImageByteFormat.png);
  //   final Uint8List pngBytes = byteData!.buffer.asUint8List();
  //   print(pngBytes);
  // }
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> _capturePng() {
    return Future.delayed(const Duration(milliseconds: 20), () async {
      try {
        RenderRepaintBoundary boundary = _chartKey.currentContext!
            .findRenderObject()! as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage();
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List? pngBytes = byteData?.buffer.asUint8List();
        // print(pngBytes);
        if (pngBytes != null) {
          final directory = await getDownloadPath();
          final imagePath = await file.File(
                  '$directory/${DateTime.now().toIso8601String()}.png')
              .create();
          await imagePath.writeAsBytes(pngBytes);
          print(imagePath);
//DateFormat.yMEd().format(DateTime.now()).toString()
          // confirmDownload();
        } else {
          confirmDownload();
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void confirmDownload() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Image Downloaded"),
        content: const Text(
            "Your download is compledted!! \n Check Downloads folder."),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(onPressed: _capturePng, child: const Text('Download')),
          RepaintBoundary(
            key: _chartKey,
            child: Container(
                height: 400,
                width: double.infinity,
                child: TimeSeriesChart(
                  _seriesChartData!,
                  animate: true,
                  defaultRenderer: LineRendererConfig(includePoints: true),
                  // domainAxis: constNumericAxisSpec(
                  //   tickProviderSpec:
                  //      BasicNumericTickProviderSpec(zeroBound: false),
                  //   //  viewport:NumericExtents(2016.0, 2022.0),
                  // ),
                  animationDuration: Duration(seconds: 3),
                  behaviors: [
                    LinePointHighlighter(
                        symbolRenderer:
                            CustomCircleSymbolRenderer() // add this line in behaviours
                        )
                  ],
                  selectionModels: [
                    SelectionModelConfig(
                        changedListener: (SelectionModel model) {
                      if (model.hasDatumSelection) {
                        final value = model.selectedSeries[0]
                            .measureFn(model.selectedDatum[0].index);
                        CustomCircleSymbolRenderer.value =
                            value.toString(); // paints the tapped value
                      }
                    })
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class TempVal {
  var time;
  double value;
  TempVal({required this.time, required this.value});
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  static String? value;
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      Color? fillColor,
      FillPatternType? fillPattern,
      Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        fillPattern: fillPattern,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.white);
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(charts_text.TextElement("$value", style: textStyle),
        (bounds.left).round(), (bounds.top - 28).round());
  }
}
