# flutter_pdf_view_fhi

This project is an example of creating a widget that displays a PDF document obtained from the provided URL. The following code explains the same.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Use `http` lib to load PDF URL link](https://pub.dev/packages/http)
- [Use `printing` to display PDF content](https://pub.dev/packages/printing)

## Fetch PDF content
```
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
```

## Display PDF content
```
PdfPreview(
    allowPrinting: false,
    allowSharing: false,
    canChangePageFormat: false,
    build: (format) => snapshot.data!,
);
```

##Full Source
```
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
```
