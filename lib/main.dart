import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((value) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Clock clock = Clock();
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: clock)],
      child: MaterialApp(
          title: 'Alarm Clock',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          home: const MyHomePage(title: 'CLOCK')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final timeString = Provider.of<Clock>(context, listen: true).timeString;
    Widget mat = Material(
        child: Container(
      alignment: const Alignment(-0.2, -0.2),
      child: Text(timeString),
    ));
    return mat;
  }
}
