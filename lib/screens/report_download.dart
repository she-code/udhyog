import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:udhyog/widgets/mobile_down.dart'
    if (dart.library.html) 'package:udhyog/widgets/web_download.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/press.dart';
import '../providers/press.dart';

class ReportDownload extends StatelessWidget {
  //const ReportDownload({Key? key}) : super(key: key);
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Download pdf'),
        onPressed: _createPdf,
      ),
    );
  }

  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString('Turbo Cast (India) Pvt. Ltd.',
        PdfStandardFont(PdfFontFamily.timesRoman, 30),
        brush: PdfBrushes.black, bounds: Rect.fromLTWH(10, 10, 300, 50));
    page.graphics.drawImage(PdfBitmap(await _readImageData('mainLogo.png')),
        Rect.fromLTWH(0, 50, 60, 60));

    //creating table
    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 14),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2, bottom: 5));
    grid.columns.add(count: 9);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];

    header.cells[0].value = 'Date';
    header.cells[1].value = 'Time';
    header.cells[2].value = 'Temprature-Tank Top(C)';
    header.cells[3].value = 'Temprature-Tank Lower(C)';
    header.cells[4].value = 'Temprature-Block (C)';
    header.cells[5].value = 'Temprature-Home (C)';
    header.cells[6].value = 'Dwell Time';
    header.cells[7].value = 'Part Counter';
    header.cells[8].value = 'Power Consumption';

//Add the styles to specific cell
    header.style = PdfGridCellStyle(
        backgroundBrush: PdfBrushes.lightGreen,
        cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12));

    PdfGridRow row = grid.rows.add();
    // press.map((press) =>row.cells[press].value
    for (int i = 0; i < press.length; i++) {
      // row.cells[i].value = (press[i].blockTemp).toString();
      row.cells[0].value = press[i].createdAt.toIso8601String();
      row.cells[1].value = DateTime.now().toIso8601String();
      row.cells[2].value = press[i].tankTopTemp.toString();
      row.cells[3].value = press[i].tankLowerTemp.toString();
      row.cells[4].value = press[i].blockTemp.toLowerCase();
      row.cells[5].value = press[i].hoseTemp.toString();
      row.cells[6].value = press[i].timer.toString();
      row.cells[7].value = press[i].partCount.toString();
      row.cells[8].value = '1';
    }
    // row = grid.rows.add();
    // row.cells[0].value = '1';
    // row.cells[1].value = 'RR';
    // row.cells[2].value = 7;

    // row = grid.rows.add();
    // row.cells[0].value = '1';
    // row.cells[1].value = 'RR';
    // row.cells[2].value = 7;

    grid.draw(page: document.pages.add(), bounds: Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'output.pdf');
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
