import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

class pdfExport {
  final pw = pdf.Document();

  Widget PaddedText(
    final String text, {
    final TextAlign align = TextAlign.left,
  }) =>
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: align,
        ),
      );
  Future<Uint8List> makePdf(var pressDetails, String name) async {
    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/images/mainLogo.png'))
            .buffer
            .asUint8List());

    final image = pdf.MemoryImage(
        (await rootBundle.load('assets/images/mainLogo.png'))
            .buffer
            .asUint8List());
    pw.addPage(
      pdf.MultiPage(
        build: (pdf.Context context) => [
          pdf.Container(child: pdf.Image(image, width: 50, height: 50)),
          pdf.Container(
              margin: pdf.EdgeInsets.symmetric(vertical: 15),
              alignment: pdf.Alignment.center,
              child: pdf.Text(StringUtils.capitalize(name, allWords: true),
                  textScaleFactor: 1.3,
                  style:
                      // PdfGoogleFonts.cormorantBold(),
                      pdf.TextStyle(
                    fontSize: 20,
                  ))),
          pdf.Container(
              margin: pdf.EdgeInsets.only(bottom: 15),
              child: pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                  children: [
                    pdf.Text("Press: "),
                    pdf.Text(""),
                    pdf.Container(
                        child: pdf.Text(
                      "Duration: ",
                    ))
                  ])),
          pdf.Table.fromTextArray(context: context, data: <List<String>>[
            <String>[
              'Date',
              'Time',
              'Temp-Tank Top(C)',
              'Temp-Tank Lower(C)',
              'Block Temp',
              'Hose Temp',
              'Dwell Time',
              'Part Counter',
              'Power Consumption'
            ],
            ...pressDetails
                .asMap()
                .entries
                .map((index) => [
                      DateFormat.MEd()
                          .format(
                              DateTime.parse(pressDetails[index.key].createdAt))
                          .toString(),
                      DateFormat.Hm()
                          .format(
                              DateTime.parse(pressDetails[index.key].createdAt))
                          .toString(),
                      pressDetails[index.key].TankTopTemp.toString(),
                      pressDetails[index.key].TankLowerTemp.toString(),
                      pressDetails[index.key].BlockTemp.toString(),
                      pressDetails[index.key].HoseTemp.toString(),
                      pressDetails[index.key].Timer.toString(),
                      pressDetails[index.key].PartCount.toString(),
                      pressDetails[index.key].powerConsumption.toString()
                    ])
                .toList()
          ]),
        ],
      ),
    );
    return pw.save();
  }
}
   //Column(children: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Column(
      //         children: [
      //           Text("Attention to: ${press.company_id}"),
      //           Text(press.press_id),
      //         ],
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //       ),
      //       SizedBox(
      //         height: 150,
      //         width: 150,
      //         child: Image(imageLogo),
      //       )
      //     ],
      //   ),
      //   Table(border: TableBorder.all(color: PdfColors.black), children: [
      //     TableRow(children: [
      //       Padding(
      //         padding: EdgeInsets.all(20),
      //         child: Text('Temperature Report',
      //             style: Theme.of(context).header4,
      //             textAlign: TextAlign.center),
      //       )
      //     ])
      //   ])
      // ]);
    
    