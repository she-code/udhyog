import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:udhyog/widgets/mobile_down.dart'
    if (dart.library.html) 'package:udhyog/widgets/web_download.dart';
import 'package:flutter/services.dart' show rootBundle;

class ReportDownload extends StatelessWidget {
  const ReportDownload({Key? key}) : super(key: key);

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
    page.graphics
        .drawString('Welcome', PdfStandardFont(PdfFontFamily.helvetica, 30));
    page.graphics.drawImage(PdfBitmap(await _readImageData('mainLogo.png')),
        Rect.fromLTWH(0, 100, 440, 550));

    //creating table
    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 5, top: 2, bottom: 5));
    grid.columns.add(count: 3);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Roll no';
    header.cells[1].value = 'Name';
    header.cells[2].value = 'Class';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'RR';
    row.cells[2].value = 7;

    row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'RR';
    row.cells[2].value = 7;

    row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'RR';
    row.cells[2].value = 7;

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
