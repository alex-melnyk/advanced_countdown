import 'dart:async';

import 'package:advanced_countdown/advanced_countdown.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _durationForward = ValueNotifier(Duration.zero);
  final _durationBackward = ValueNotifier(
    const Duration(minutes: 59, seconds: 59),
  );
  final _durationMillis = ValueNotifier(Duration.zero);

  Timer? _timer;
  Timer? _timerMillis;

  @override
  void initState() {
    super.initState();

    _startTimers();
  }

  @override
  void reassemble() {
    super.reassemble();

    _startTimers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('ADVANCED COUNTDOWN'),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _durationForward,
                    builder: (context, value, child) {
                      return AdvancedCountdown(
                        value: value,
                        animationDuration: const Duration(milliseconds: 250),
                        style: Theme.of(context).textTheme.displayMedium,
                      );
                    },
                  ),
                  const SizedBox(width: 40),
                  ValueListenableBuilder(
                    valueListenable: _durationBackward,
                    builder: (context, value, child) {
                      return AdvancedCountdown(
                        value: value,
                        animationDuration: const Duration(milliseconds: 250),
                        style: Theme.of(context).textTheme.displayMedium,
                      );
                    },
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _durationMillis,
                builder: (context, value, child) {
                  return AdvancedCountdown(
                    value: value,
                    animationMillisecondsDuration:
                        const Duration(milliseconds: 100),
                    style: Theme.of(context).textTheme.displayMedium,
                    displayHours: true,
                    displayMilliseconds: true,
                    millisecondsLength: 1,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerMillis?.cancel();

    super.dispose();
  }

  void _startTimers() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      _handleTimerUpdate,
    );

    _timerMillis?.cancel();
    _timerMillis = Timer.periodic(
      const Duration(milliseconds: 100),
      _handleTimerMillisUpdate,
    );
  }

  void _handleTimerUpdate(Timer timer) {
    _durationForward.value += const Duration(seconds: 1);
    _durationBackward.value += const Duration(seconds: -1);

    if (_durationForward.value.inSeconds.remainder(60) == 60) {
      _durationForward.value = Duration.zero;
    }

    if (_durationBackward.value.inSeconds.remainder(60) == 0) {
      _durationBackward.value = const Duration(minutes: 59, seconds: 59);
    }
  }

  void _handleTimerMillisUpdate(Timer timer) {
    _durationMillis.value += const Duration(milliseconds: 100);

    if (_durationMillis.value.inSeconds.remainder(60) >= 5) {
      _durationMillis.value = Duration.zero;
    }
  }
}
