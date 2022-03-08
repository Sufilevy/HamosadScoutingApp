import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app/misc/data_container.dart';
import 'package:hamosad_scouting_app/pages/pages.dart';

class StopwatchTimer extends StatefulWidget {
  final String title;
  final DataContainer<int> secondsData;

  const StopwatchTimer({
    Key? key,
    required this.title,
    required this.secondsData,
  }) : super(key: key);

  @override
  State<StopwatchTimer> createState() => _StopwatchTimerState();
}

class _StopwatchTimerState extends State<StopwatchTimer> {
  late final Stopwatch stopwatch;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    stopwatch.stop();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int elapsed) {
    var seconds = (elapsed ~/ 1000).toString().padLeft(2, '0');
    var milliseconds = (elapsed % 1000 ~/ 100).toString();
    return "$seconds.$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.title,
            style: AppFont(size: 22.5).getFont(),
          ),
        ),
        Stack(
          children: [
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: accentColor,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text(
                    "      ",
                    style: AppFont(size: 30).getFont(),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text(
                  formatTime(stopwatch.elapsedMilliseconds),
                  style: AppFont(size: 30).getFont(),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: TextButton(
                onPressed: () => setState(
                  () {
                    if (stopwatch.isRunning) {
                      stopwatch.stop();
                      widget.secondsData.value =
                          stopwatch.elapsedMilliseconds ~/ 1000;
                    } else {
                      stopwatch.start();
                    }
                  },
                ),
                child: Text(
                  stopwatch.isRunning
                      ? langEntries['stop'][currentLang['i']]
                      : langEntries['start'][currentLang['i']],
                  style: AppFont(
                    color: Theme.of(context).canvasColor,
                    size: 22.5,
                  ).getFont(),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: TextButton(
                onPressed: () => setState(
                  () {
                    if (!stopwatch.isRunning) {
                      stopwatch.reset();
                      widget.secondsData.value =
                          stopwatch.elapsedMilliseconds ~/ 1000;
                    }
                  },
                ),
                child: Text(
                  langEntries['reset'][currentLang['i']],
                  style: AppFont(
                    color: Theme.of(context).canvasColor,
                    size: 22.5,
                  ).getFont(),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(stopwatch.isRunning
                      ? Colors.green.shade900
                      : accentColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
