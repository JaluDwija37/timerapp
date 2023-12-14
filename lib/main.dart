import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timerapp/widget.dart';
import './timer.dart';
import './timermodel.dart';
import './settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    ];

    timer.startWork();
    return MaterialApp(
      title: 'My Work Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Work Timer'),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return menuItems.toList();
                },
                onSelected: (s) {
                  if (s == 'Settings') {
                    goToSettings(context);
                  }
                },
              )
            ],
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            return Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: ProductivityButton(
                            color: Color(0xff009688),
                            text: "Work",
                            onPressed: () => timer.startWork())),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: ProductivityButton(
                            color: Color(0xff607D8B),
                            text: "Short Break",
                            onPressed: () => timer.startBreak(true))),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: ProductivityButton(
                            color: Color(0xff455A64),
                            text: "Long Break",
                            onPressed: () => timer.startBreak(false))),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                      initialData: '00:00',
                      stream: timer.stream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        TimerModel timer = (snapshot.data == '00:00')
                            ? TimerModel('00:00', 1)
                            : snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: availableWidth / 3,
                            lineWidth: 10.0,
                            percent: timer.percent,
                            center: Text(
                              timer.time,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            progressColor: Color(0xff009688),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: ProductivityButton(
                            color: Color(0xff212121),
                            text: 'Stop',
                            onPressed: () => timer.stopTimer())),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: ProductivityButton(
                            color: Color(0xff009688),
                            text: 'Restart',
                            onPressed: () => timer.startTimer())),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
              ),
              Text("Dibuat oleh Adecya Jalu Mahadwija NIM: 21201032"),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
              ),
            ]);
          })),
    );
  }

  void emptyMethod() {}

  void goToSettings(BuildContext context) {
    print('in gotoSettings');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}
