import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timerapp/widget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController txtWork = TextEditingController();
  final TextEditingController txtShort = TextEditingController();
  final TextEditingController txtLong = TextEditingController();
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late SharedPreferences prefs;

  int workTime = 0;
  int shortBreak = 0;
  int longBreak = 0;

  @override
  void initState() {
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        Text("Work", style: textStyle),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
        TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, WORKTIME, updateSetting),
        Text("Short", style: textStyle),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtShort,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
        Text(
          "Long",
          style: textStyle,
        ),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtLong,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
      ],
      padding: const EdgeInsets.all(20.0),
    ));
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME) ?? 30;
    shortBreak = prefs.getInt(SHORTBREAK) ?? 5;
    longBreak = prefs.getInt(LONGBREAK) ?? 20;

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          shortBreak += value;
          if (shortBreak >= 1 && shortBreak <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtShort.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          longBreak += value;
          if (longBreak >= 1 && longBreak <= 180) {
            prefs.setInt(LONGBREAK, longBreak);
            setState(() {
              txtLong.text = longBreak.toString();
            });
          }
        }
        break;
    }
  }
}
