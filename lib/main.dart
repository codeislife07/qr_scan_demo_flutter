import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Android QR SCANNER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String qrResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                //scan qr and return value

                //ask camera permission
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  // We haven't asked for permission yet or the permission has been denied before, but not permanently.
                  status = await Permission.camera.request();
                }

                if (status == PermissionStatus.granted) {
                  String? cameraScanResult = await scanner.scan();
                  if (cameraScanResult != null) {
                    setState(() {
                      qrResult = cameraScanResult;
                    });
                  }
                }
              },
              child: const Text("Scan"),
            ),
            Text(
              'Result:- $qrResult',
            ),
          ],
        ),
      ),
    );
  }
}
