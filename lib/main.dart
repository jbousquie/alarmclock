import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((value) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
  static TextStyle timeStyle = TextStyle(color: Colors.black.withOpacity(0.8));
  static TextStyle dateStyle =
      TextStyle(fontSize: 12, color: Colors.black.withOpacity((0.6)));
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final Clock clock = Provider.of<Clock>(context, listen: true);
    final String timeString = clock.timeString;
    final String dateString = clock.dateString;
    final RichText timeText = RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
          TextSpan(text: '$timeString\n', style: timeStyle),
          TextSpan(text: dateString, style: dateStyle)
        ]));
    Widget mat = Material(
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // ignore: avoid_print
            onTap: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SettingsPage(title: 'Réglages horloge');
                  }))
                },
            child: Container(
              alignment: const Alignment(-0.2, -0.2),
              child: timeText,
            )));
    return mat;
  }
}
