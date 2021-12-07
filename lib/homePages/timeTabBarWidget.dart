import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimeTabBarWidget extends StatefulWidget {
  const TimeTabBarWidget({Key key}) : super(key: key);

  @override
  _TimeTabBarWidgetState createState() => _TimeTabBarWidgetState();
}

class _TimeTabBarWidgetState extends State<TimeTabBarWidget> {
  Stream stream =
      Stream.periodic(const Duration(seconds: 1)).asBroadcastStream();
  @override
  Widget build(BuildContext context) {
    var _value = Provider.of<int>(context);
     return Container(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('StreamProvider Example', style: TextStyle(fontSize: 20)),
        SizedBox(height: 50),
        Text('${_value.toString()}',
            style: Theme.of(context).textTheme.headline4)
      ],
    )));
  }
}

class StreamTimeProvider extends ChangeNotifier {
  Stream<int> intStream() {
    return Stream<int>.periodic(const Duration(seconds: 1)).asBroadcastStream();
  }
}
