import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

// flutter_pdfview: ^1.0.3+5 <- 이 패키지는 별로임.
class PdfViewPage extends StatelessWidget {
  final PDFDocument document;
  final Widget bottomAd;
  final String title;
  PdfViewPage(this.document, {this.title, this.bottomAd});

  @override
  Widget build(BuildContext context) {
    final title_ = title == null ? ' ' : title;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(title_),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: PDFViewer(
              document: document,
              zoomSteps: 1,
              showPicker: false,
              scrollDirection: Axis.vertical,
            )),
            if (this.bottomAd != null) this.bottomAd
          ],
        )));
  }
}
