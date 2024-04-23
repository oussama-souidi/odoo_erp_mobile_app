import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateInvoicePdf(String customerName, String invoiceNumber, double amount) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Invoice'),
            pw.Text('Customer: $customerName'),
            pw.Text('Invoice Number: $invoiceNumber'),
            pw.Text('Amount: \$$amount'),
          ],
        );
      },
    ),
  );

  // Use await to wait for PDF saving and return the result
  return await pdf.save();
}
