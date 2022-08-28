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
    List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    final company = Provider.of<Auth>(context, listen: false).company;
    final pressDataList = args[0];
    final duration = args[1];
    final pressName = args[2];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: PdfPreview(
        build: (context) =>
            pdfExport().makePdf(pressDataList, company!, duration, pressName),
      ),
    );
  }
}
