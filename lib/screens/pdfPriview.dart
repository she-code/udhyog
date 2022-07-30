import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/pdfExport.dart';

class PdfPreviewPage extends StatelessWidget {
  static String routeName = '/pdfPreview';
  //var pressDataList;
  // PdfPreviewPage({Key? key, required this.pressDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pressDataList = ModalRoute.of(context)?.settings.arguments;
    final company = Provider.of<Auth>(context, listen: false).company;

    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: PdfPreview(
        build: (context) => pdfExport().makePdf(pressDataList, company),
      ),
    );
  }
}
