import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  const NativeCodeScreen({super.key});

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batterylevel = 'Unknown battery level';
  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level:  '${e.message}'.";
    }
    setState(() {
      _batterylevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: getBatteryLevel,
              child: (const Text(
                'get battery level',
              ))),
          const SizedBox(
            height: 50,
          ),
          Text(_batterylevel, style: Theme.of(context).textTheme.bodyLarge)
        ]),
      ),
    );
  }
}
