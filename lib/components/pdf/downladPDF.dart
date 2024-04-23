import 'dart:io';
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadPdf(Future<Uint8List> pdfBytesFuture) async {
  // Request storage permission (if needed)
  final storageStatus = await Permission.storage.request();
  if (!storageStatus.isGranted) {
    throw Exception('Storage permission is required to download the PDF.');
  }

  // Await the generation of the PDF data (Uint8List)
  final pdfBytes = await pdfBytesFuture;

  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/invoice.pdf';
  final file = File(path);
  await file.writeAsBytes(pdfBytes);

  // Optionally open the downloaded PDF
  await OpenFilex.open(path);
}
