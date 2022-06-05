import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pdf View Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: FutureBuilder<Uint8List?>(
          future: _fetchPdfContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PdfPreview(
                allowPrinting: false,
                allowSharing: false,
                canChangePageFormat: false,
                build: (format) => snapshot.data!,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<Uint8List?> _fetchPdfContent() async {
    const String url = "https://www.orimi.com/pdf-test.pdf";

    try {
      final result = await http.get(
        Uri.parse(url),
      );
      return Uint8List.fromList(result.bodyBytes);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
